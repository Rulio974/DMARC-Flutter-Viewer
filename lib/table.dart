import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config/const_var.dart';
import 'config/fetch_data.dart';

import 'main.dart';

import 'navigator/noAnimation.dart';

import 'config/columns_config.dart';

class DmarcTable extends StatefulWidget {
  final List<PlutoRow>? rows;

  const DmarcTable({super.key, required this.rows});

  @override
  State<DmarcTable> createState() => _DmarcTableState();
}

class _DmarcTableState extends State<DmarcTable> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double width = screenSize.width;
    double height = screenSize.height;
    return Container(
      margin: const EdgeInsets.only(left: 10),
      height: height,
      width: width / 1.2,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(-5, 0),
        )
      ]),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 7,
                    blurRadius: 7,
                  ),
                ],
              ),
              margin: EdgeInsets.all(width / 32),
              child: PlutoGrid(
                configuration: PlutoGridConfiguration(
                  style: PlutoGridStyleConfig(
                      activatedColor: hqYellowActivated,
                      gridBorderColor: hqYellow,
                      gridBorderRadius: BorderRadius.circular(15)),
                ),
                columns: columns,
                rows: widget.rows!,
                // rows: snapshot.data!,
                onRowDoubleTap: (event) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmer la suppression'),
                        content: const Text(
                            'Voulez vous vraiment supprimer cette entrée ?'),
                        actions: <Widget>[
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red)),
                            child: const Text(
                              'Annuler',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Supprimer'),
                            onPressed: () {
                              http
                                  .delete(Uri.parse(
                                      'http://82.165.240.99:80/rptrecord/${event.row.cells['id_field']?.value}'))
                                  .then(
                                (http.Response response) {
                                  if (kDebugMode) {
                                    print(
                                        'status code: ${response.statusCode}');
                                    print('Body: ${response.body}');
                                    print(
                                        'Deleting record with ID: ${event.row.cells['id_field']?.value}'); // Ajoutez cette ligne pour imprimer l'ID
                                  }

                                  Navigator.push(
                                    context,
                                    NoAnimationPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                                  setState(() {
                                    fetchData();
                                  });
                                },
                              ).catchError(
                                (error) {
                                  if (kDebugMode) {
                                    print('Error: $error');
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

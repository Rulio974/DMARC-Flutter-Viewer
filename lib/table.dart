import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'main.dart';

import 'navigator/noAnimation.dart';

import 'config/columns_config.dart';

class DmarcTable extends StatefulWidget {
  @override
  State<DmarcTable> createState() => _DmarcTableState();
}

class _DmarcTableState extends State<DmarcTable> {
  Future<List<PlutoRow>> fetchData() async {
    final response = await http.get(Uri.parse("http://82.165.240.99:80"));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      return data.map((item) {
        return PlutoRow(
          cells: {
            'id_field': PlutoCell(value: item['id']),
            'ip_field': PlutoCell(value: item['ip'].toString()),
            'ipv6_field': PlutoCell(
                value: item['ip6'] != null ? item['ip6'].toString() : 'NULL'),
            'rcount_field': PlutoCell(value: item['rcount'].toString()),
            'dkim_field': PlutoCell(value: item['dkimdomain']),
            'spf_d_field': PlutoCell(value: item['spfresult']),
            'spf_r_field': PlutoCell(value: item['spfresult']),
            'spf_a_fiel': PlutoCell(value: item['spf_align']),
            'dkim_a_fiel': PlutoCell(value: item['dkim_align']),
            'id_h_fiel': PlutoCell(value: item['identifier_hfrom']),
            // 'Treated' : PlutoCell(value: item['treated'])
          },
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double width = screenSize.width;
    double height = screenSize.height;

    return FutureBuilder(
      future: fetchData(),
      builder: ((BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
              margin: EdgeInsets.only(left: 10),
              height: height,
              width: width / 1.2,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2), // couleur de l'ombre
                  spreadRadius: 5, // expansion de l'ombre
                  blurRadius: 7, // flou de l'ombre
                  offset: Offset(-5, 0), // décalage de l'ombre
                )
              ]),

              // margin:
              //     EdgeInsets.fromLTRB(width / 32, width / 20, width / 32, 0),
              child: PlutoGrid(
                configuration: const PlutoGridConfiguration(
                  style: PlutoGridStyleConfig(
                    gridBorderColor: Colors.blue,
                    gridBorderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
                columns: columns,
                rows: snapshot.data!,
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
                                    .then((http.Response response) {
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
                                }).catchError((error) {
                                  if (kDebugMode) {
                                    print('Error: $error');
                                  }
                                });
                              },
                            ),
                          ],
                        );
                      });
                },
              ));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      }),
    );
  }
}

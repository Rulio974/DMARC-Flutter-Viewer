// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import '../../config/fetch_data.dart';
import '../../classic/widgets/tabs.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../main.dart';

import '../../navigator/noAnimation.dart';

import '../../config/columns_config.dart';

class DmarcTable extends StatefulWidget {
  final List<PlutoRow>? rows;

  const DmarcTable({super.key, required this.rows});

  @override
  State<DmarcTable> createState() => _DmarcTableState();
}

class _DmarcTableState extends State<DmarcTable> {
  String filter = "";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double width = screenSize.width;
    double height = screenSize.height;
    return Expanded(
      child: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).backgroundColor, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(-5, 0),
          )
        ]),
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tabs(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 7,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(width / 32),
                  child: PlutoGrid(
                    configuration: PlutoGridConfiguration(
                      style: PlutoGridStyleConfig(
                          columnTextStyle:
                              TextStyle(color: Theme.of(context).hintColor),
                          gridBackgroundColor:
                              Theme.of(context).backgroundColor,
                          borderColor: Colors.grey,
                          cellTextStyle: GoogleFonts.ubuntu(),
                          activatedBorderColor: Theme.of(context).primaryColor,
                          activatedColor: Theme.of(context).focusColor,
                          gridBorderColor: Theme.of(context).primaryColor,
                          gridBorderRadius: BorderRadius.circular(15),
                          menuBackgroundColor: Colors.red),
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

                                        MotionToast(
                                          icon: Icons.check_circle,
                                          primaryColor: const Color(0xff6fcf97),
                                          secondaryColor: Colors.white,
                                          backgroundType: BackgroundType.solid,
                                          title: const Text('Succès !'),
                                          description: const Text(
                                              "L'entrée à été traitée avec succès"),
                                          displayBorder: true,
                                          displaySideBar: false,
                                        ).show(context);
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
        ),
      ),
    );
  }
}

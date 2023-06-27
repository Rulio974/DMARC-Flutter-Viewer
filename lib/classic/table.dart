// ignore_for_file: deprecated_member_use

import 'package:dmarc_flutter/classic/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import '../config/fetch_data.dart';
import 'widgets/tabs.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../config/url_path_private.dart';

// import '../main.dart';

import '../navigator/noAnimation.dart';

import '../config/columns_config.dart';

class ClassicDmarcTable extends StatefulWidget {
  final List<PlutoRow>? rows;

  const ClassicDmarcTable({super.key, required this.rows});

  @override
  State<ClassicDmarcTable> createState() => _ClassicDmarcTableState();
}

class _ClassicDmarcTableState extends State<ClassicDmarcTable> {
  String filter = "";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double width = screenSize.width;
    double height = screenSize.height;
    return Container(
      margin: const EdgeInsets.only(left: 10),
      height: height,
      width: width / 1.2,
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
            Tabs(),
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
                        gridBackgroundColor: Theme.of(context).backgroundColor,
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
                    showAnimatedDialog(
                      animationType: DialogTransitionType.fade,
                      curve: Curves.fastOutSlowIn,
                      duration: const Duration(milliseconds: 300),
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirmer la suppression'),
                          content: Container(
                            height: height / 10,
                            width: width / 5,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: height / 35,
                                  ),
                                  const Text(
                                      'Voulez vous vraiment supprimer cette entrée ? '),
                                  Table(
                                    children: [
                                      TableRow(children: [
                                        Text("IP"),
                                        Text(
                                            "${event.row.cells['ip_field']?.value}"),
                                      ]),
                                      TableRow(children: [
                                        Text("Nombre d'occurences"),
                                        Text(
                                            "${event.row.cells['rcount_fiel']?.value}"),
                                      ]),
                                      TableRow(children: [
                                        Text("DKIM Domain"),
                                        Text(
                                            "${event.row.cells['dkim_fiel']?.value}"),
                                      ]),
                                      TableRow(children: [
                                        Text("SPF Domain"),
                                        Text(
                                            "${event.row.cells['spf_d_field']?.value}"),
                                      ]),
                                      TableRow(children: [
                                        Text("Expéditeur"),
                                        Text(
                                            "${event.row.cells['id_h_fiel']?.value}"),
                                      ]),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
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
                                    .delete(url.resolve(
                                        '/rptrecord/${event.row.cells['id_field']?.value}'))
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
                                          builder: (context) =>
                                              ClassicHomePage()),
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
    );
  }
}

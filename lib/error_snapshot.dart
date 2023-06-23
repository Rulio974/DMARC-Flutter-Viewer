// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorSnap extends StatelessWidget {
  final Object? error;
  final void Function() reload;

  const ErrorSnap({super.key, required this.error, required this.reload});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double width = screenSize.width;
    double height = screenSize.height;

    return Center(
      child: Container(
        height: height / 2,
        width: width / 2,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 7,
              blurRadius: 7,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Connexion impossible : $error",
              style: GoogleFonts.ubuntu(fontSize: height / 40),
            ),
            Text(
              "Verifiez vos paramètres ainsi que la configuration serveur",
              style: GoogleFonts.ubuntu(fontSize: height / 50),
            ),
            TextButton(
              onPressed: () {
                reload();
              },
              child: const Text("Recharger"),
            ),
          ],
        ),
      ),
    );
  }
}

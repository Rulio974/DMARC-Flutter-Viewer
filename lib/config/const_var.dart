// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xfff9b104),
    focusColor: const Color(0xfffbf4dc),
    primaryColor: const Color(0xfff9b104),
    backgroundColor: Colors.white,
    secondaryHeaderColor: Colors.white,
    shadowColor: Colors.grey.withOpacity(0.2),
    iconTheme: const IconThemeData(color: Colors.white),
    primaryColorDark: Colors.black,
    hintColor: Colors.black,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xff0D1B2A),
    focusColor: const Color(0xff415A77),
    primaryColor: const Color(0xff0D1B2A),
    backgroundColor: const Color(0xff415A77),
    secondaryHeaderColor: const Color(0xff778DA9),
    shadowColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.white),
    hintColor: Colors.white,
  );
}

const Color hqYellow = Color(0xfff9b104);
const Color hqYellowActivated = Color(0xfffbf4dc);

var chartFont = GoogleFonts.ubuntu();
var tabFont = GoogleFonts.ubuntu(color: Colors.white);
var logo_network =
    'https://buylandingpagesdesign.com/wp-content/uploads/2017/01/logo-1.png';

const int delayTime = 0;

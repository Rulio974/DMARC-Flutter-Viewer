// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xfff9b104),
      focusColor: const Color(0xfffbf4dc),
      primaryColor: const Color(0xfff9b104),
      backgroundColor: Colors.white);

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    focusColor: const Color(0xfffbf4dc),
    primaryColor: const Color(0xfff9b104),
  );
}

const Color hqYellow = Color(0xfff9b104);
const Color hqYellowActivated = Color(0xfffbf4dc);

var chartFont = GoogleFonts.ubuntu();
var tabFont = GoogleFonts.ubuntu(color: Colors.white);

const int delayTime = 0;

import 'package:dmarc_flutter/classic/home.dart';
import 'package:flutter/material.dart';
import 'config/const_var.dart';
import 'config/theme_notifier.dart';

import 'classic/charts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'side/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('layout', true);

  Future<Widget> buildApp() async {
    final prefs = await SharedPreferences.getInstance();
    bool prefValue = prefs.getBool('layout') ??
        true; // Utilise 'true' comme valeur par défaut si 'maCle' n'est pas encore défini

    if (prefValue) {
      return MyApp();
    } else {
      return SideApp();
    }
  }

  runApp(
    FutureBuilder(
        future: buildApp(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ThemeNotifier>(
                  create: (_) => ThemeNotifier(),
                ),
                ChangeNotifierProvider<VisibilityProvider>(
                  create: (_) => VisibilityProvider(),
                ),
              ],
              child: snapshot.data,
            );
          } else {
            return const CircularProgressIndicator();
          }
        }),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
        title: 'Dmarc Flutter Viewer',
        debugShowCheckedModeBanner: false,
        theme: themeNotifier.darkTheme
            ? ThemeClass.darkTheme
            : ThemeClass.lightTheme,
        home: ClassicHomePage());
  }
}

class SideApp extends StatelessWidget {
  SideApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
        title: 'Dmarc Flutter Viewer',
        debugShowCheckedModeBanner: false,
        theme: themeNotifier.darkTheme
            ? ThemeClass.darkTheme
            : ThemeClass.lightTheme,
        home: SideHomePage());
  }
}

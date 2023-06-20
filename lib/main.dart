import 'package:flutter/material.dart';
import 'config/const_var.dart';
import 'config/fetch_data.dart';
import 'config/theme_notifier.dart';
import 'widgets/error_snapshot.dart';

import 'table.dart';
import 'charts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('ip_adress', "0.0.0.0");
  print(prefs.getString('ip_adress'));
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // final SharedPreferences prefs;

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'Dmarc Flutter Viewer',
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.darkTheme
          ? ThemeClass.darkTheme
          : ThemeClass.lightTheme,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  // final SharedPreferences prefs;

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> sharedNumber = [];

  void reload() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: hqYellow,
        body: FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: delayTime),
        () => fetchData(),
      ),
      builder: ((BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).iconTheme.color,
          ));
        } else if (snapshot.hasData) {
          return Row(
            children: [
              Charts(rows: snapshot.data),
              DmarcTable(
                rows: snapshot.data,
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return ErrorSnap(
            error: snapshot.error,
            reload: reload,
          );
        } else {
          return ErrorSnap(
            error: "No Data",
            reload: reload,
          );
        }
      }),
    ));
  }
}

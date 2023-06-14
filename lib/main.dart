import 'package:flutter/material.dart';
import 'navigator/noAnimation.dart';
import 'config/const_var.dart';
import 'config/fetch_data.dart';

import 'table.dart';
import 'charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dmarc Flutter Viewer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> sharedNumber = [];

  void updateData(List<String> newData) {
    setState(() {
      sharedNumber = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: hqYellow,
        body: FutureBuilder(
          future: Future.delayed(
            const Duration(seconds: delayTime),
            () => fetchData(),
          ),
          builder: ((BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
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
              return Text('${snapshot.error}');
            } else {
              return const Center(child: Text('Pas de données disponibles'));
            }
          }),
        ));
  }
}

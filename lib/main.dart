import 'package:flutter/material.dart';
import 'navigator/noAnimation.dart';
import 'config/HQ_colors.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hqYellow,
      // appBar: AppBar(
      //   title: const Text('DMARC Viewer'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           NoAnimationPageRoute(builder: (context) => HomePage()),
      //         );
      //       },
      //       icon: const Icon(
      //         Icons.replay_outlined,
      //       ),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.settings),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.help),
      //     ),
      //   ],
      // ),
      body: Row(
        children: [
          Charts(),
          DmarcTable(),
        ],
      ),
    );
  }
}

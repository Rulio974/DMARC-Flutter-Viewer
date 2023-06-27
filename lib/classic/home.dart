import 'package:dmarc_flutter/classic/charts.dart';
import 'package:dmarc_flutter/classic/table.dart';
import 'package:dmarc_flutter/config/const_var.dart';
import 'package:dmarc_flutter/error_snapshot.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../config/fetch_data.dart';

class ClassicHomePage extends StatefulWidget {
  // final SharedPreferences prefs;

  ClassicHomePage({Key? key}) : super(key: key);

  @override
  State<ClassicHomePage> createState() => _ClassicHomePageState();
}

class _ClassicHomePageState extends State<ClassicHomePage> {
  List<String> sharedNumber = [];

  void reload() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: hqYellow,
        body: FutureBuilder(
      future: Future.wait([
        Future.delayed(
          const Duration(seconds: delayTime),
          () => fetchData(),
        ),
        Future.delayed(
          const Duration(seconds: delayTime),
          () => fetchFileCount(),
        ),
      ]),
      builder: ((BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Lottie.asset("load.json"));
        } else if (snapshot.hasData) {
          return Row(
            children: [
              Charts(
                  rows: snapshot.data![0] as List<PlutoRow>,
                  count: snapshot.data![1] as int),
              ClassicDmarcTable(
                rows: snapshot.data![0] as List<PlutoRow>,
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

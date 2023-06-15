import 'package:flutter/material.dart';
import 'header_tab.dart';
import '../config/pick_file.dart';
import '../tabs/tab_help.dart';
import '../tabs/tab_params.dart';

class Tabs extends StatefulWidget {
  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  List<String> sharedNumber = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(child: SizedBox()),
        HeaderTab(
          tabFunction: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ParamDialog();
                });
          },
          icone: const Icon(
            Icons.settings,
            size: 30,
            color: Colors.white,
          ),
          title: "Paramètres",
        ),
        const Expanded(child: SizedBox()),
        HeaderTab(
          tabFunction: () {},
          icone: const Icon(
            Icons.help,
            size: 30,
            color: Colors.white,
          ),
          title: "Aide",
        ),
        const Expanded(child: SizedBox()),
        HeaderTab(
          tabFunction: () {
            uploadFile();
          },
          icone: const Icon(
            Icons.arrow_circle_down_outlined,
            size: 30,
            color: Colors.white,
          ),
          title: "Charger",
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}

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
          icone: Icon(
            Icons.settings,
            size: 30,
            color: Theme.of(context).iconTheme.color,
          ),
          title: "Paramètres",
        ),
        const Expanded(child: SizedBox()),
        HeaderTab(
          tabFunction: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return HelpDialog();
                });
          },
          icone: Icon(
            Icons.help,
            size: 30,
            color: Theme.of(context).iconTheme.color,
          ),
          title: "Aide",
        ),
        const Expanded(child: SizedBox()),
        HeaderTab(
          tabFunction: () {
            uploadFile();
          },
          icone: Icon(
            Icons.arrow_circle_down_outlined,
            size: 30,
            color: Theme.of(context).iconTheme.color,
          ),
          title: "Charger",
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}

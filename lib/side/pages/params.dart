// ignore_for_file: library_private_types_in_public_api

import 'package:dmarc_flutter/config/const_var.dart';
import 'package:dmarc_flutter/config/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Param extends StatefulWidget {
  const Param({Key? key}) : super(key: key);

  @override
  _ParamState createState() => _ParamState();
}

class _ParamState extends State<Param> {
  late TextEditingController ipController = TextEditingController();
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FractionColumnWidth(.3),
          1: FractionColumnWidth(.7),
        },
        children: [
          TableRow(children: [
            Center(
              child: SwitchListTile(
                title: const Text("Dark Mode"),
                value: Provider.of<ThemeNotifier>(context).darkTheme,
                onChanged: (val) {
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .toggleTheme();
                },
              ),
            ),
          ]),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // ipFocusNode.dispose();
    super.dispose();
  }
}

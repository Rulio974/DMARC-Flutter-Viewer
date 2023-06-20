import 'package:dmarc_flutter/config/const_var.dart';
import 'package:dmarc_flutter/config/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<TableRow> buildTableRows(
    BuildContext context, TextEditingController ipController, double width) {
  return [
    TableRow(children: [
      const Center(
        child: Text(
          "Adresse IP",
          style: TextStyle(fontSize: 20),
        ),
      ),
      Center(
        child: SizedBox(
          width: width / 16,
          child: TextField(
            controller: ipController,
            decoration: const InputDecoration(
              hintText: "Votre serveur",
            ),
          ),
        ),
      ),
    ]),
    TableRow(children: [
      const Center(
        child: Text(
          "Dark Mode",
          style: TextStyle(fontSize: 20),
        ),
      ),
      Center(
        child: Switch(
          value: Provider.of<ThemeNotifier>(context).darkTheme,
          onChanged: (val) {
            Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
          },
        ),
      ),
    ]),
  ];
}

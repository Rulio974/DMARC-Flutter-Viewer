import 'package:dmarc_flutter/config/const_var.dart';
import 'package:dmarc_flutter/config/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParamDialog extends StatefulWidget {
  const ParamDialog({Key? key}) : super(key: key);

  @override
  _ParamDialogState createState() => _ParamDialogState();
}

class _ParamDialogState extends State<ParamDialog> {
  final TextEditingController ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      child: Container(
        height: height / 3,
        width: width / 3,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FractionColumnWidth(.4),
            1: FractionColumnWidth(.6),
          },
          children: [
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
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .toggleTheme();
                  },
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

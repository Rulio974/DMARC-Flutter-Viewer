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
  late TextEditingController ipController = TextEditingController();
  // late FocusNode ipFocusNode;
  String ip_controller = "";

  @override
  void initState() {
    super.initState();
    _loadIpAddress().then((value) {
      ip_controller = value;
    });
  }

  Future<String> _loadIpAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('ip_address') ?? "";
  }

  // Future<void> _saveIpAddress() async {
  //   if (!ipFocusNode.hasFocus) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('ip_address', ipController.text);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(ip_controller);
    return Dialog(
      child: Container(
        height: height / 3,
        width: width / 2,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FractionColumnWidth(.3),
            1: FractionColumnWidth(.7),
          },
          children: [
            TableRow(children: [
              Center(
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
                    // focusNode: ipFocusNode,
                    decoration: InputDecoration(hintText: "_loadIpAddress();"),
                  ),
                ),
              ),
            ]),
            TableRow(children: [
              Center(
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

  @override
  void dispose() {
    ipController.dispose();
    // ipFocusNode.dispose();
    super.dispose();
  }
}

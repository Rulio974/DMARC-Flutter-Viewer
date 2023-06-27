// ignore_for_file: library_private_types_in_public_api

import 'package:dmarc_flutter/config/const_var.dart';
import 'package:dmarc_flutter/config/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../charts.dart';

class ParamDialog extends StatefulWidget {
  const ParamDialog({Key? key}) : super(key: key);

  @override
  _ParamDialogState createState() => _ParamDialogState();
}

class _ParamDialogState extends State<ParamDialog> {
  late TextEditingController ipController = TextEditingController();
  // late FocusNode ipFocusNode;
  bool _isVisible = true;
  bool _isSidemenue = false;

  @override
  void initState() {
    super.initState();
    _loadVisibilityPreference();
  }

  Future<void> _loadVisibilityPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isVisible = prefs.getBool('isVisible') ?? true;

    setState(() {
      _isVisible = isVisible;
    });
  }

  Future<void> _updateVisibilityPreference(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isVisible', newValue);

    // ignore: use_build_context_synchronously
    Provider.of<VisibilityProvider>(context, listen: false)
        .updateVisibility(newValue);

    setState(() {
      _isVisible = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      child: Container(
        height: height / 3,
        width: width / 4,
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
            TableRow(children: [
              Center(
                child: SwitchListTile(
                  title: const Text("Afficher le logo"),
                  value: _isVisible,
                  onChanged: (newValue) {
                    _updateVisibilityPreference(newValue);
                  },
                ),
              ),
            ]),
            TableRow(children: [
              Center(
                child: SwitchListTile(
                  title: const Text("Menu sur le côté"),
                  value: _isVisible,
                  onChanged: (newValue) {
                    _updateVisibilityPreference(newValue);
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
    // ipFocusNode.dispose();
    super.dispose();
  }
}

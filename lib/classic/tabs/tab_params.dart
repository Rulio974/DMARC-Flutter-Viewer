// ignore_for_file: library_private_types_in_public_api

import 'package:dmarc_flutter/config/const_var.dart';
import 'package:dmarc_flutter/config/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../config/url_path_private.dart';

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

  void deleteAllData() async {
    var response = await http.post(url.resolve('/deleteAll'));

    if (response.statusCode == 200) {
      print('Toutes les données ont été supprimées avec succès');
    } else {
      print('Échec de la suppression des données');
    }
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
                child: Text(
                  "Paramètres",
                  style: GoogleFonts.ubuntu(fontSize: 30),
                ),
              )
            ]),
            const TableRow(children: [
              Divider(
                height: 20,
                color: Colors.black,
              ),
            ]),
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
            const TableRow(children: [
              Center(
                child: SwitchListTile(
                  title: Text("Menu sur le côté (En cours de développement)"),
                  value: false,
                  onChanged: null,
                  // value: _isVisible,

                  // onChanged: (newValue) {
                  //   _updateVisibilityPreference(newValue);
                  // },
                ),
              ),
            ]),
            TableRow(children: [
              SizedBox(
                height: height / 30,
              )
            ]),
            TableRow(children: [
              TextButton(
                  onLongPress: () {
                    print("this is it");
                    deleteAllData();
                  },
                  onPressed: () {
                    MotionToast(
                      icon: Icons.error_outline,
                      primaryColor: Colors.red,
                      secondaryColor: Colors.white,
                      backgroundType: BackgroundType.solid,
                      title: const Text(
                        'Echec !',
                        style: TextStyle(color: Colors.white),
                      ),
                      description: const Text(
                        "Vous devez presser le boutton plus longtemps",
                        style: TextStyle(color: Colors.white),
                      ),
                      displayBorder: true,
                      displaySideBar: false,
                    ).show(context);
                  },
                  child: const Text("Supprimer les entrées"))
            ])
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

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class HelpDialog extends StatefulWidget {
  const HelpDialog({super.key});

  @override
  State<HelpDialog> createState() => _HelpDialogState();
}

class _HelpDialogState extends State<HelpDialog> {
  List<String> sharedNumber = [];
  List<dynamic> helpData = [];

  @override
  void initState() {
    super.initState();
    readJsonData('help.json').then((data) {
      setState(() {
        helpData = data;
      });
    });
  }

  Future<List<dynamic>> readJsonData(String filename) async {
    String jsonString = await rootBundle.loadString(filename);
    return json.decode(jsonString);
  }

  IconData getIconBasedOnName(String iconName) {
    switch (iconName) {
      case 'delete':
        return Icons.delete;
      // Ajoutez tous les cas pour les autres noms d'icônes que vous avez
      // dans votre fichier JSON
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double width = screenSize.width;
    double height = screenSize.height;
    return Dialog(
      child: Container(
        height: height / 2,
        width: width / 2,
        color: Colors.blue,
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: helpData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Icon(getIconBasedOnName(helpData[index]['icone'])),
                      Text(helpData[index]['text']),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

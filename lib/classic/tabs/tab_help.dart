import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/get_icone.dart';

class HelpDialog extends StatefulWidget {
  const HelpDialog({super.key});

  @override
  State<HelpDialog> createState() => _HelpDialogState();
}

class _HelpDialogState extends State<HelpDialog> {
  List<String> sharedNumber = [];
  List<dynamic> helpData = [];
  late List<bool> _isHovering;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    readJsonData('help.json').then((data) {
      setState(() {
        helpData = data;
        _isHovering = List.filled(helpData.length, false);
      });
    });
  }

  Future<List<dynamic>> readJsonData(String filename) async {
    String jsonString = await rootBundle.loadString(filename);
    return json.decode(jsonString);
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
        color: Colors.white,
        child: selectedIndex == null
            ? GridView.builder(
                shrinkWrap: true,
                itemCount: helpData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  childAspectRatio: 1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return MouseRegion(
                    onEnter: (PointerEvent details) {
                      setState(() {
                        _isHovering[index] = true;
                      });
                    },
                    onExit: (PointerEvent details) {
                      setState(() {
                        _isHovering[index] = false;
                      });
                    },
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 230),
                        margin: _isHovering[index]
                            ? const EdgeInsets.all(8)
                            : const EdgeInsets.all(10),
                        padding: _isHovering[index]
                            ? const EdgeInsets.all(7)
                            : const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              helpData[index]?['short_text'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.bold),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Icon(
                                getIconForName(
                                  helpData[index]?['icon']!,
                                ),
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : ExpandedWidget(
                data: helpData[selectedIndex!],
                onExit: () {
                  setState(() {
                    selectedIndex = null;
                    print("ok");
                  });
                },
              ),
      ),
    );
  }
}

class ExpandedWidget extends StatelessWidget {
  final dynamic data;
  final Function onExit;

  const ExpandedWidget({required this.data, required this.onExit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onExit(),
      child: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              data?['short_text'],
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
            ),
            Text(
              data?['text'],
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Icon(
                getIconForName(
                  data?['icon']!,
                ),
                color: Colors.amberAccent,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

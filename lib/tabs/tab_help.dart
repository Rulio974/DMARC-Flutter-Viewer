import 'package:flutter/material.dart';

class HelpDialog extends StatefulWidget {
  const HelpDialog({super.key});

  @override
  State<HelpDialog> createState() => _HelpDialogState();
}

class _HelpDialogState extends State<HelpDialog> {
  List<String> sharedNumber = [];

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
              itemCount: 8,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

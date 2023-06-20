import 'package:flutter/material.dart';
import '../config/const_var.dart';

class HeaderTab extends StatelessWidget {
  Icon icone;
  String title;
  final void Function() tabFunction;

  HeaderTab({
    super.key,
    required this.icone,
    required this.title,
    required this.tabFunction,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double width = screenSize.width;
    double height = screenSize.height;

    return Expanded(
      child: GestureDetector(
        onTap: () async {
          tabFunction();
        },
        child: Container(
          height: height / 20,
          decoration: BoxDecoration(
            color: hqYellow,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceAround,
              children: [
                Container(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: icone,
                    ),
                  ),
                ),
                Container(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      title,
                      style: tabFont,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

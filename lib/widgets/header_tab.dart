import 'package:flutter/material.dart';
import '../config/const_var.dart';

class HeaderTab extends StatelessWidget {
  final Icon icone;
  final String title;
  final void Function() tabFunction;

  const HeaderTab({
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
      child: InkWell(
        onTap: () {
          tabFunction();
        },
        child: Container(
          height: height / 20,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
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
                FittedBox(
                  fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: icone,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
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

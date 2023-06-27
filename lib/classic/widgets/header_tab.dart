import 'package:flutter/material.dart';
import '../../config/const_var.dart';

class HeaderTab extends StatefulWidget {
  final Icon icone;
  final String title;
  final void Function() tabFunction;

  const HeaderTab({
    Key? key,
    required this.icone,
    required this.title,
    required this.tabFunction,
  }) : super(key: key);

  @override
  _HeaderTabState createState() => _HeaderTabState();
}

class _HeaderTabState extends State<HeaderTab> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double width = screenSize.width;
    double height = screenSize.height;

    double containerHeight = isHovered ? height / 18 : height / 20;

    return Expanded(
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: InkWell(
          onTap: () {
            widget.tabFunction();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: height / 20,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: isHovered ? 10 : 5,
                  spreadRadius: isHovered ? 5 : 2,
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
                      child: widget.icone,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      widget.title,
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
      ),
    );
  }
}

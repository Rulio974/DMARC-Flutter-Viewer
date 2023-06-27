import 'package:dmarc_flutter/config/const_var.dart';
import 'package:flutter/material.dart';
import 'package:countup/countup.dart';

class Number extends StatefulWidget {
  final String data;
  final String text;

  const Number({
    Key? key,
    required this.data,
    required this.text,
  }) : super(key: key);

  @override
  _NumberState createState() => _NumberState();
}

class _NumberState extends State<Number> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var containerSize = isHovered ? height / 4 : height / 5;

    return MouseRegion(
      onEnter: (event) => setState(() {
        isHovered = true;
      }),
      onExit: (event) => setState(() {
        isHovered = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: containerSize,
        width: containerSize,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Countup(
                      begin: 0,
                      end: double.parse(widget.data),
                      duration: const Duration(seconds: 2),
                    )
                    // child: Text(
                    //   widget.data,
                    //   style: chartFont, // Remplacez par votre style de texte
                    // ),
                    ),
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: Text(
                    widget.text,
                    style: chartFont, // Remplacez par votre style de texte
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

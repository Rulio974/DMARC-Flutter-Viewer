import 'package:dmarc_flutter/config/const_var.dart';
import 'package:flutter/material.dart';

class Number extends StatefulWidget {
  final String data;
  final String text;

  const Number({
    super.key,
    required this.data,
    required this.text,
  });

  @override
  State<Number> createState() => NumberState();
}

class NumberState extends State<Number> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double width = screenSize.width;
    double height = screenSize.height;

    return Container(
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
      height: height / 5,
      width: height / 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  widget.data,
                  style: chartFont,
                ),
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
                  style: chartFont,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

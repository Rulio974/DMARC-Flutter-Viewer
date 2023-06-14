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
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color:
                Colors.grey.withOpacity(0.5), // this is the color of the shadow
            spreadRadius: 5, // this is the spread of the shadow
            blurRadius: 7, // this is the blur of the shadow
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
                child: Text(widget.data),
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Text(widget.text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

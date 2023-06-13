import 'package:flutter/material.dart';
import 'charts/number.dart';

class Charts extends StatefulWidget {
  @override
  State<Charts> createState() => ChartsState();
}

class ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Number(),
        Number(),
        Number(),
      ]),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'widgets/number.dart';

class Charts extends StatefulWidget {
  final List<PlutoRow>? rows;

  const Charts({super.key, required this.rows});

  @override
  State<Charts> createState() => ChartsState();
}

class ChartsState extends State<Charts> {
  int? dataReturn() {
    var lenght = widget.rows?.length;

    return lenght;
  }

  @override
  Widget build(BuildContext context) {
    var lenght = dataReturn();
    return Expanded(
        child: Container(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Number(
          data: lenght.toString(),
          text: "Entrées à traiter",
        ),
        Number(
          data: lenght.toString(),
          text: "Entrées à traiter",
        ),
        Number(
          data: lenght.toString(),
          text: "Entrées à traiter",
        ),
      ]),
    ));
  }
}

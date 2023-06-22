import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'widgets/number.dart';

class Charts extends StatefulWidget {
  final List<PlutoRow>? rows;
  final int count;

  const Charts({super.key, required this.rows, required this.count});

  @override
  State<Charts> createState() => ChartsState();
}

class ChartsState extends State<Charts> {
  List<int?> dataReturn() {
    var lenght = widget.rows?.length;
    var failCount = widget.rows
        ?.where((row) => row.cells['spf_d_field']?.value == "fail")
        .length;
    return [lenght, failCount];
  }

  @override
  Widget build(BuildContext context) {
    var lenght = dataReturn()[0];
    var count = dataReturn()[1];
    return Expanded(
        child: Container(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Number(
          data: lenght.toString(),
          text: "Entrées à traiter",
        ),
        Number(
          data: widget.count.toString(),
          text: "Rapports ajoutés",
        ),
        Number(
          data: count.toString(),
          text: "Entrées en échecs",
        ),
      ]),
    ));
  }
}

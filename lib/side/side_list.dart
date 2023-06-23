import 'package:dmarc_flutter/side/pages/charts.dart';
import 'package:dmarc_flutter/side/pages/table.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class SideList extends StatefulWidget {
  // final SharedPreferences prefs;
  final PageController pageController;
  final AsyncSnapshot<List<Object>> snapshot;
  const SideList(
      {Key? key, required this.pageController, required this.snapshot})
      : super(key: key);

  @override
  State<SideList> createState() => SideListState();
}

class SideListState extends State<SideList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: widget.pageController,
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              DmarcTable(
                rows: widget.snapshot.data![0] as List<PlutoRow>,
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Charts(
                rows: widget.snapshot.data![0] as List<PlutoRow>,
                count: widget.snapshot.data![1] as int,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

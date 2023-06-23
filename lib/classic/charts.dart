import 'package:dmarc_flutter/config/const_var.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    Size screenSize = MediaQuery.of(context).size;

    double width = screenSize.width;
    double height = screenSize.height;
    var isVisible = Provider.of<VisibilityProvider>(context).isVisible;

    var lenght = dataReturn()[0];
    var count = dataReturn()[1];
    return Expanded(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      if (isVisible)
        Padding(
          padding: EdgeInsets.all(5),
          child: Image.asset(
            "logo.png",
          ),
        ),
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
    ]));
  }
}

class VisibilityProvider with ChangeNotifier {
  bool _isVisible = true;

  bool get isVisible => _isVisible;

  VisibilityProvider() {
    _loadVisibilityPreference();
  }

  Future<void> _loadVisibilityPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isVisible = prefs.getBool('isVisible') ?? true;
    notifyListeners();
  }

  Future<void> updateVisibility(bool newValue) async {
    _isVisible = newValue;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isVisible', newValue);
    notifyListeners();
  }
}

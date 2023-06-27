import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'header_tab.dart';
import '../../config/pick_file.dart';
import '../tabs/tab_help.dart';
import '../tabs/tab_params.dart';

class Tabs extends StatefulWidget {
  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  List<String> sharedNumber = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(child: SizedBox()),
        HeaderTab(
          tabFunction: () {
            showAnimatedDialog(
              context: context,
              animationType: DialogTransitionType.slideFromTop,
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 800),
              barrierDismissible: true,
              builder: (BuildContext context) {
                return const ParamDialog();
              },
            );
          },
          icone: Icon(
            Icons.settings,
            size: 30,
            color: Theme.of(context).iconTheme.color,
          ),
          title: "Paramètres",
        ),
        const Expanded(child: SizedBox()),
        HeaderTab(
          tabFunction: () {
            showAnimatedDialog(
                animationType: DialogTransitionType.slideFromTop,
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 800),
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return const HelpDialog();
                });
          },
          icone: Icon(
            Icons.help,
            size: 30,
            color: Theme.of(context).iconTheme.color,
          ),
          title: "Aide",
        ),
        const Expanded(child: SizedBox()),
        HeaderTab(
          tabFunction: () async {
            var succes = await uploadFile();
            setState(() {});
            if (succes == true) {
              // ignore: use_build_context_synchronously
              MotionToast(
                icon: Icons.check_circle,
                primaryColor: const Color(0xff6fcf97),
                secondaryColor: Colors.white,
                backgroundType: BackgroundType.solid,
                title: const Text('Succès !'),
                description: const Text("Le rapport à été ajouté avec succès"),
                displayBorder: true,
                displaySideBar: false,
              ).show(context);
            }
          },
          icone: Icon(
            Icons.arrow_circle_down_outlined,
            size: 30,
            color: Theme.of(context).iconTheme.color,
          ),
          title: "Charger",
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}

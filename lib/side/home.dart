import 'package:dmarc_flutter/config/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import '../error_snapshot.dart';
import 'side_list.dart';

class SideHomePage extends StatefulWidget {
  // final SharedPreferences prefs;

  SideHomePage({Key? key}) : super(key: key);

  @override
  State<SideHomePage> createState() => SideHomePageState();
}

class SideHomePageState extends State<SideHomePage> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  void reload() {
    setState(() {});
  }

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([fetchData(), fetchFileCount()]),
        builder: ((BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).iconTheme.color,
            ));
          } else if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SideMenu(
                  // Page controller to manage a PageView
                  controller: sideMenu,
                  style: style,
                  // Will shows on top of all items, it can be a logo or a Title text
                  // title: Image.asset('assets/images/easy_sidemenu.png'),
                  // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
                  // footer: Text('demo'),
                  // Notify when display mode changed
                  onDisplayModeChanged: (mode) {
                    print(mode);
                  },
                  items: [
                    SideMenuItem(
                      priority: 0,
                      title: 'Table DMARC',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.home),
                    ),
                    SideMenuItem(
                      priority: 1,
                      title: 'Métriques',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                ),
                SideList(
                  pageController: pageController,
                  snapshot: snapshot,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return ErrorSnap(
              error: snapshot.error,
              reload: reload,
            );
          } else {
            return ErrorSnap(
              error: "No Data",
              reload: reload,
            );
          }
        }),
      ),
    );
  }
}

var style = SideMenuStyle(
    displayMode: SideMenuDisplayMode.auto,
    decoration: BoxDecoration(),
    openSideMenuWidth: 200,
    compactSideMenuWidth: 40,
    hoverColor: Colors.blue[100],
    selectedColor: Colors.lightBlue,
    selectedIconColor: Colors.white,
    unselectedIconColor: Colors.black54,
    backgroundColor: Colors.grey,
    selectedTitleTextStyle: TextStyle(color: Colors.white),
    unselectedTitleTextStyle: TextStyle(color: Colors.black54),
    iconSize: 20,
    itemBorderRadius: const BorderRadius.all(
      Radius.circular(5.0),
    ),
    showTooltip: true,
    itemHeight: 50.0,
    itemInnerSpacing: 8.0,
    itemOuterPadding: const EdgeInsets.symmetric(horizontal: 5.0),
    toggleColor: Colors.black54);

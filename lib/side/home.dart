import 'package:dmarc_flutter/side/pages/charts.dart';
import 'package:dmarc_flutter/config/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../error_snapshot.dart';
import 'pages/table.dart';

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
                      title: 'Dashboard',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.home),
                      badgeContent: const Text(
                        '3',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SideMenuItem(
                      priority: 1,
                      title: 'Settings',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          DmarcTable(
                            rows: snapshot.data![0] as List<PlutoRow>,
                          ),
                        ],
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Charts(
                            rows: snapshot.data![0] as List<PlutoRow>,
                            count: snapshot.data![1] as int,
                          ),
                        ],
                      ),
                    ],
                  ),
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
          return ErrorSnap(
            error: "No Data",
            reload: reload,
          );
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

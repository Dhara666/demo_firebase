import 'package:demofirebase/pages/geolocation_pages/google_map_page.dart';
import 'package:demofirebase/pages/razor_pay/razor_pay.dart';
import 'package:flutter/material.dart';

import '../pages/demo_page.dart';
import '../pages/home_page/home_page.dart';
import '../pages/in_app_purchase/in_app_purchase_page.dart';

class DashBoardProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List<Widget> dashboardList = <Widget>[
    const DemoPage(title: "DEMO PAGE1"),
    const DemoPage(title: "DEMO PAGE2"),
    const DemoPage(title: "DEMO PAGE3"),
    const DemoPage(title: "DEMO PAGE4"),
  ];

  // Future<bool> onWillPop(context) async {
  //   return (await showDialog(
  //     context: context,
  //     builder: (_) => AppCustomAlertDialog(
  //         message: S.of(context).areYouSureYouWantToExit),
  //   )) ??
  //       false;
  // }

  void goToPublicMembersPage() {
    drawerNavigator(1);
    notifyListeners();
  }

  void goToHomePage() {
    selectedIndex = 0;
    notifyListeners();
  }

  void drawerNavigator(int index) {
    switch (index) {
      case 0:
        selectedIndex = 0;
        break;
      case 1:
        selectedIndex = 1;
        break;
      case 2:
        selectedIndex = 2;
        break;
      case 3:
        selectedIndex = 3;
        break;
    }
    notifyListeners();
  }
}

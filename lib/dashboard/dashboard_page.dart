import 'package:demofirebase/common/app_appbar.dart';
import 'package:demofirebase/common/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/dashboard_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardProvider>(
      builder: (BuildContext context, DashBoardProvider dashboardProvider, _) {
        return //WillPopScope(
          // onWillPop: () => dashboardProvider.onWillPop(context),
          //child:
          Scaffold(
            key: scaffoldKey,
            drawer: AppDrawer(scaffoldKey: scaffoldKey),
            appBar: AppAppBar(
              title: "APP DRAWER",
              showUser: true,
              isHome: false,
              onUserTap: () => scaffoldKey.currentState!.openDrawer(),
            ),
            body: dashboardProvider
                .dashboardList[dashboardProvider.selectedIndex],
         //  ),
        );
      },
    );
  }
}

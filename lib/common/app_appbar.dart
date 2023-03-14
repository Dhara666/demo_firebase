import 'package:flutter/material.dart';

class AppAppBar extends PreferredSize {
  final bool isHome;
  final bool showDrawer;
  final double margin;
  final GestureTapCallback? onUserTap;
  final bool showUser;
  final String title;

  AppAppBar({
    Key? key,
    this.isHome = true,
    this.showDrawer = true,
    this.margin = 20,
    this.onUserTap,
    this.showUser = true,
    this.title = "HOME PAGE",
    Widget? child,
    Size? preferredSize,
  }) : super(
          key: key,
          child: Container(),
          preferredSize: Size.fromHeight(AppBar(
                elevation: 0,
              ).preferredSize.height *
              1),
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFF00bec8),
          Color(0xFF10c078),
        ]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isHome)
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                  margin: EdgeInsets.only(right: margin, left: 12),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
            ),
          if (showDrawer)
            InkWell(
              onTap: onUserTap,
              child: Container(
                margin: EdgeInsets.only(right: margin, left: 12),
                child: const Icon(Icons.menu, color: Colors.white),
              ),
            ),
          if (!showDrawer && !isHome) const Spacer(),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          const Spacer(),
        ],
      ),
    ));
  }
}




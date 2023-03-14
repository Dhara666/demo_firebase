
import 'package:demofirebase/common/app_image_assets.dart';
import 'package:demofirebase/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constant.dart';
import 'app_custom_expansion_tile.dart';
import 'app_text.dart';

class AppDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AppDrawer({Key? key, required this.scaffoldKey}) : super(key: key);
  static const List<String> drawerList = [
    "DEMO PAGE1",
    "DEMO PAGE2",
    "DEMO PAGE3",
    "DEMO PAGE4",
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardProvider>(
      builder: (BuildContext context, DashBoardProvider dashBoardProvider, _) {
        return Drawer(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  dashBoardProvider.goToHomePage();
                  scaffoldKey.currentState!.openEndDrawer();
                },
                child: Container(
                  height: 80,
                  width: 130,
                  margin: const EdgeInsets.only(top: 55, bottom: 40),
                  alignment: Alignment.center,
                  child: const AppImageAsset(
                    isWebImage: true,
                    image: 'https://miro.medium.com/max/1200/1*p3a2mw1LTCuZbFTdVTqVjw.png',
                    height: 20,
                    width: 130,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: drawerList.length,
                  itemBuilder: (context, index) {
                    // if (index == 1) {
                    //   return buildMemberView(
                    //       context, dashBoardProvider);
                    // }
                    return buildDrawerOptions(
                        context, index, dashBoardProvider);
                  },
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(
              //     top: 30,
              //     bottom: 20,
              //   ),
              //   alignment: Alignment.center,
              //   child: const AppImageAsset(
              //     isWebImage: true,
              //     image: 'https://cdn.logo.com/hotlink-ok/logo-social.png',
              //     height: 40,
              //     width: 130,
              //     fit: BoxFit.fill,
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  InkWell buildDrawerOptions(
    BuildContext context,
    int index,
    DashBoardProvider dashBoardProvider,
  ) {
    return InkWell(
      onTap: () {
        dashBoardProvider.drawerNavigator(index);
        scaffoldKey.currentState!.openEndDrawer();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: ColorConstant.appTransparent,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: AppText(
              textStyle:
                  Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15),
              text: drawerList[index],
            ),
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
          ),
        ],
      ),
    );
  }

  // Column buildMemberView(BuildContext context,
  //     DashBoardProvider dashBoardProvider) {
  //   return Column(
  //     children: [
  //       AppCustomExpansionTile(
  //         title: 'Members',
  //         headerBackgroundColor
  //             : ColorConstant.appWhite,
  //         iconColor
  //             : ColorConstant.appBlue,
  //         textStyle:
  //             Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15),
  //         margin: EdgeInsets.zero,
  //         children: [
  //
  //           Consumer<PublicMemberProvider>(
  //             builder:
  //                 (BuildContext context, PublicMemberProvider publicMemberProvider, _) {
  //               return ListView.builder(
  //                 physics: const NeverScrollableScrollPhysics(),
  //                 itemCount: 3,
  //                 shrinkWrap: true,
  //                 padding: EdgeInsets.zero,
  //                 itemBuilder: (context, index) => Padding(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       GestureDetector(
  //                         onTap: () {
  //                           scaffoldKey.currentState!.openEndDrawer();
  //                           dashBoardProvider.goToPublicMembersPage();
  //                           publicMemberProvider.goToPublicMemberPages(index);
  //                         },
  //                         child: AppText(
  //                           text: index == 0
  //                               ? S.of(context).steeringCommittee
  //                               : index == 1
  //                                   ? S.of(context).netProFanChapters
  //                                   : S.of(context).topPerformers,
  //                           textStyle: Theme.of(context)
  //                               .textTheme
  //                               .headline2!
  //                               .copyWith(fontSize: 15),
  //                         ),
  //                       ),
  //                       const SizedBox(height: 5),
  //                       if (index != 2) const Divider(),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           )
  //         ],
  //       ),
  //       const Divider(
  //         indent: 10,
  //         endIndent: 10,
  //       ),
  //     ],
  //   );
  // }
}

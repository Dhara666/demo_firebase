import 'package:demofirebase/common/app_appbar.dart';
import 'package:demofirebase/common/app_dropdown_button.dart';
import 'package:flutter/material.dart';
import '../../common/app_custom_expansion_tile.dart';

class ExpansionTilePage extends StatefulWidget {
  const ExpansionTilePage({Key? key}) : super(key: key);

  @override
  State<ExpansionTilePage> createState() => ExpansionTilePageState();
}

class ExpansionTilePageState extends State<ExpansionTilePage> {

  static List<ContentModel> eventsYear2021List = [
    ContentModel(
      title: 'Indi-Genius Food Challenge - Winners announced',
      link:
      'https://eatrightindia.gov.in/NetProFaN/assets/netpro/events/Winners%20List_Indi-Genius%20Food%20Challenge.pdf',
    ),
    ContentModel(
      title: 'Plant Protein Breakfast Recipe Competition - Winners announced',
      link:
      'https://eatrightindia.gov.in/NetProFaN/assets/netpro/events/List%20Winners%20Protein%20Competition.pdf',
    ),
    ContentModel(
      title: 'Plant Protein Breakfast Recipe Competition !',
      link:
      'https://eatrightindia.gov.in/NetProFaN/assets/netpro/events/World%20Protein%20Day.png',
    ),
    ContentModel(
      title:
      'Registrations for the National Low Salt Cooking Challenge starts from 27th January, 2021. Submit your ',
      link: 'https://eatrightindia.gov.in/hfss/nlscc/',
    ),
    ContentModel(
      title:
      'Participate in Indi Genius Food Challenge and get a chance to win exciting prizes !',
      link:
      'https://docs.google.com/forms/d/e/1FAIpQLSdU-ZZut6ja9NPv9c0mUkZV3QQfH_iGS058z2ab8HS7cMgVcw/viewform',
    ),
  ];

  List<String> numberOfMember = [
    '4',
    '8',
    '12',
    '16',
    '20',
    '14',
    '18',
    '112',
    '120+',
  ];

 String?  numberOfMemberInvolved;
  KeyValueModel? selectedValue;
  TextEditingController v = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        isHome: true,
        showDrawer: false,
       ),
       body: Container(
        margin: const EdgeInsets.only(left: 8,right: 8),
        padding: const EdgeInsets.only(left: 8,right: 8),
        color: Colors.grey.withOpacity(0.1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        height: 55,
                      ),
                      Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Container(
                            padding: const EdgeInsets.only(top: 3),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: const <Widget>[
                                    // SizedBox(
                                    //   width: 30,
                                    //   height: 22,
                                    //   child: ClipRRect(
                                    //     borderRadius:
                                    //     BorderRadius.all(
                                    //         Radius
                                    //             .circular(
                                    //             3)),
                                    //     // child: Text("---")
                                    //     // ImageFromNetworkView(
                                    //     //   path:
                                    //     //   item.flag ?? "",
                                    //     //   boxFit: BoxFit.fill,
                                    //     // ),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 20,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text("country Name",
                                            style: TextStyle(
                                                color:
                                                Colors.black,
                                                fontFamily:
                                                'Nunito',
                                                fontSize: 16.0,
                                                letterSpacing:
                                                1.0,
                                                fontWeight:
                                                FontWeight
                                                    .w500)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          initiallyExpanded: false,
                          onExpansionChanged: (isExpand) {
                            // if (isExpand) {
                            //   model.isEmpty = false;
                            //   if (item.listPlans == null) {
                            //     airaloIsoCode =
                            //         item.airaloIsoCode;
                            //     model.getPlansforCountry(
                            //         item.countryCode,
                            //         index,
                            //         item.airaloIsoCode,
                            //         item.countryName);
                            //   }
                            //   setState(() {});
                            // }
                          },
                          /*trailing:  Image.asset(App.ic_down, width: 16, height: 16,),*/
                          children:buildRowList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: AppDropdownButton(
                  hint: "Please Select",
                  value: numberOfMemberInvolved,
                  dropdownItems: numberOfMember,
                  onChanged: (String? request) {
                    setState(() {
                      numberOfMemberInvolved = request;
                    });
                  },
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
               shrinkWrap: true, itemCount: 5,
               itemBuilder: (BuildContext context, int index,) {
                return AppCustomExpansionTile(
                  onExpansionChanged: ((newState) {
                  }),
                  headerBackgroundColor: Colors.orange,
                  title: "Poster",
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: eventsYear2021List.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(eventsYear2021List[index].title.toString()));
                        })
                  ],
                );
               },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildRowList() {
        List<Widget> list = [];
        Widget widget = Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            margin: const EdgeInsets.only(
              top: 16.0,
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Package Name",
                         style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Nunito',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: const Text( "7 day",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0,
                            color: Colors.black,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              "USD" + " ",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(width: 4),
                            Text(
                              "\$",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "200",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: ()  {
                    // List<CountryPackage.Package> availablePackageList =
                    // countryItem.packageListV3
                    //     .where(
                    //         (elementItem) => elementItem.id != element.id)
                    //     .toList();
                    // print(
                    //     '--> available package ${availablePackageList.length}');
                    //
                    // await Navigator.push(
                    //     state.context,
                    //     MaterialWithModalsPageRoute(
                    //       builder: (context) => PackageDetailsV3('',
                    //           airaloIsoCode: countryItem.airaloIsoCode,
                    //           selectedPackage: element,
                    //           listPlanItem: availablePackageList,
                    //           bannerItem: false),
                    //       settings: RouteSettings(
                    //         name: 'PDP_Page',
                    //       ),
                    //     ));
                    // state.setState(() {});
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(left: 4, right: 1),
                      child: Container(
                          height: 38.0,
                          width: 104.0,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF54E674),
                                  Color(0xFF2AC940)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(7),
                                topRight: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child:  const Center(
                            child:  Text("Buy Now",
                              style:  TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ))),
                )
              ],
            ));
        list.add(widget);
        list.add(widget);
        list.add(widget);
        return list;
  }

}

class KeyValueModel{
  String? itemName;
  String? itemId;
  KeyValueModel({this.itemName,this.itemId});
}
class ContentModel {
  ContentModel({
    this.title,
    this.image,
    this.link,
  });

  @required String? title;
  String? image;
  String? link;

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
    title: json["title"],
    image: json["image"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "link": link,
  };
}
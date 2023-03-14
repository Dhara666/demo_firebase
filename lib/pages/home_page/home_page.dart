import 'dart:developer';
import 'package:demofirebase/common/app_button.dart';
import 'package:demofirebase/common/webview.dart';
import 'package:demofirebase/dashboard/dashboard_page.dart';
import 'package:demofirebase/pages/razor_pay/razor_pay.dart';
import 'package:demofirebase/pages/widget/widget_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../common/app_appbar.dart';
import '../../common/app_photo_view.dart';
import '../../services/notification_service.dart';
import '../geolocation_pages/google_map_page.dart';
import '../in_app_purchase/in_app_purchase_page.dart';
import '../widget/expansion_tile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRemoteValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Firebase"),
      // ),
      appBar: AppAppBar(
         isHome: false,
        showDrawer: false,
      ),
      body: ListView(
        children: <Widget>[
          AppButton(buttonText: "Send Firebase Notification",
            onTap: () async {
              String? token;
              await FirebaseMessaging.instance.getToken().then((value) {
                  token = value;
                  print("--->fcmToken--> $token");
                });
               NotificationService().sendNotification(title: "Dara want to call you", body: "Dara send to message",token: token);
            },
          ),
          AppButton(
            buttonText: "Google Map",
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const GoogleMapPage()));
            },
          ),
          AppButton(
            buttonText: "Razor pay",
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RazorpayPage()));
            },
          ),
          AppButton(
            buttonText: "Web view",
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => MyWebView(
                    title: "Terms of use",
                    selectedUrl:
                    "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/",
                  ),
                ),
              );
            },
          ),
          AppButton(
            buttonText: "In app purchase",
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const InAppPurchasePage(),
                ),
              );
            },
          ),
          AppButton(
            buttonText: "App drawer",
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DashboardPage()));
            },
          ),
          AppButton(
            buttonText: "Photo view",
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AppPhotoView(
                    url: 'http://www.androidcoding.in/wp-content/uploads/fetch_http_call.jpg',
                    isAppbar: true,
                  )));
            },
          ),  AppButton(
            buttonText: "Widget",
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WidgetPage()));
            },
          ),
          AppButton(
            buttonText: "Facebook login",
            onTap: () {
              onTapFacebookLogin();
            },
          ),
          AppButton(
            buttonText: "phone login",
            onTap: () {

            },
          ),
        ],
      ),
    );
  }

  Future<void> onTapFacebookLogin() async {
    // ignore: invalid_use_of_protected_member
    // state.setState(() {
    //   isLoading = true;
    // });
    try {
      UserCredential? userCredential = await signInWithFacebook();
      if (userCredential != null) {
        print("------>userCredential$userCredential");
        // print('FB Account Details --> ${userCredential.user?.email}');
        // List<UserModel> userList = await userService.getUserList();
        // UserModel isUser = userList.firstWhere(
        //         (value) => value.userID == userCredential.user.uid,
        //     orElse: () => null);
        // if (isUser != null && isUser.isPurchase == true) {
        //   Navigator.pushAndRemoveUntil(
        //     state.context,
        //     SlideLeftRoute(page: HomeScreen()),
        //         (route) => false,
        //   );
        // } else {
        //   UserModel userModel = UserModel(
        //       email: userCredential.user.email,
        //       userID: userCredential.user.uid,
        //       firstName: userCredential.user.displayName,
        //       isPurchase: false,
        //       type: "facebook");
        //   await userService.createUser(userModel);
        //   // ignore: invalid_use_of_protected_member
        //   state.setState(() {
        //     isLoading = false;
        //   });
        //   Navigator.pushAndRemoveUntil(
        //     state.context,
        //     SlideLeftRoute(page: StartSubscriptionScreen()),
        //         (route) => false,
        //   );
        // }
        // // ignore: invalid_use_of_protected_member
        // state.setState(() {
        //   isLoading = false;
        // });
      } else {
        // ignore: invalid_use_of_protected_member
        // state.setState(() {
        //   isLoading = false;
        // });
      }
    } catch (e) {
      // ignore: invalid_use_of_protected_member
      // state.setState(() {
      //   isLoading = false;
      // });
      print("e");
      print(e);
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if(result.status == LoginStatus.success){
      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  getRemoteValue() {
    log('Config getRemoteValue');
    FirebaseRemoteConfig firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    String baseUrl = firebaseRemoteConfig.getString('version_code');
    log('Config baseurl --> $baseUrl');
    if (baseUrl == '1.0.0') {
      print("---->hello");
    } else {
      print("--->else");
    }
  }

// Future<void> getRemoteValue(BuildContext context) async {
//   FirebaseRemoteConfig firebaseRemoteConfig = FirebaseRemoteConfig.instance;
//   String baseUrl = firebaseRemoteConfig.getString('base_url');
//   logs('Config baseurl --> $baseUrl');
//   API.instance.nBaseURL = baseUrl;
//   String updateType = firebaseRemoteConfig.getString('update_type');
//   logs('Config update type --> $updateType');
//   if(updateType != 'none') {
//     String remoteAppVersion = firebaseRemoteConfig.getString('current_version');
//     logs('Config app version --> $remoteAppVersion');
//     String whatsNew = firebaseRemoteConfig.getString('whats_new');
//     logs('Config whats new --> $whatsNew');
//     String updateLink = Platform.isAndroid
//         ? firebaseRemoteConfig.getString('android_path')
//         : firebaseRemoteConfig.getString('ios_path');
//     logs('Config update link --> $updateLink');
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     logs('App version --> ${packageInfo.version}');
//     String tmpPackageVersion = packageInfo.version.replaceAll('.', '');
//     logs('Tmp Package Version --> $tmpPackageVersion');
//     if (num.parse(tmpPackageVersion) < num.parse(remoteAppVersion)) {
//       isUpdateAvailable.value = true;
//       if (updateType == 'soft') {
//         isSoftUpdate.value = true;
//       }
//       Get.dialog(
//         barrierDismissible: false,
//         AlertDialog(
//           insetPadding: EdgeInsets.symmetric(horizontal: 16),
//           backgroundColor: ColorStyle.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           contentPadding: EdgeInsets.symmetric(horizontal: 14),
//           content: Container(
//             width: MediaQuery.of(context).size.width,
//             margin: const EdgeInsets.symmetric(vertical: 24),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SvgPicture.asset(
//                   ImageStyle.newAppLogo,
//                   height: 32,
//                   width: 32,
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'New version available (${addPoints(remoteAppVersion.toString())})',
//                   style: TextStylesProductSans.textStyles_16.copyWith(
//                     color: ColorStyle.hex('#212121'),
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 if (whatsNew.isNotEmpty) SizedBox(height: 6),
//                 if (whatsNew.isNotEmpty)
//                   Text(
//                     whatsNew,
//                     textAlign: TextAlign.center,
//                     style: TextStylesProductSans.textStyles_16.copyWith(
//                       color: ColorStyle.yellow,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     if (isSoftUpdate.isTrue) Spacer(),
//                     Expanded(
//                       flex: 2,
//                       child: TextButtonCustom(
//                         onTap: () => updateLink.urlLauncher(
//                             mode: LaunchMode.externalApplication),
//                         text: 'Update',
//                         height: 48,
//                         radiusBorder: 10,
//                         colorBG: ColorStyle.scaffold,
//                         textStyle: TextStylesProductSans.textStyles_16.copyWith(
//                           color: ColorStyle.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     if (isSoftUpdate.isTrue) SizedBox(width: 20),
//                     if (isSoftUpdate.isTrue)
//                       Expanded(
//                         flex: 2,
//                         child: TextButtonCustom(
//                           onTap: () => cancelUpdate(),
//                           text: 'Cancel',
//                           height: 48,
//                           radiusBorder: 10,
//                           colorBG: ColorStyle.redColor,
//                           textStyle:
//                           TextStylesProductSans.textStyles_16.copyWith(
//                             color: ColorStyle.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     if (isSoftUpdate.isTrue) Spacer(),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//   }
// }
// cancelUpdate() {
//   Get.back();
//   final splashController = Get.put(SplashScreenController());
//   final String mobileNumber =
//       GetStorage().read(Constants.instance.kMobileNumber) ?? '';
//   debugPrint(mobileNumber);
//   if (mobileNumber.isNotEmpty) {
//     splashController.getUser(mobileNumber: mobileNumber);
//   } else {
//     Get.to(() => MobileNumber());
//   }
// }

}

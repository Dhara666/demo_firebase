import 'package:demofirebase/provider/dashboard_provider.dart';
import 'package:demofirebase/pages/home_page/home_page.dart';
import 'package:demofirebase/services/notification_service.dart';
import 'package:demofirebase/services/remote_config_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await RemoteConfigService.setupRemoteConfig();
  NotificationService().initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer =
  // FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    List<SingleChildWidget> providers = [
    ChangeNotifierProvider<DashBoardProvider>(
        create: (context) => DashBoardProvider())];
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        // navigatorObservers: [observer],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue, fontFamily: 'AbhayaLibre'
        ),
        home: const HomePage(),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(body: Home()),
//     );
//   }
// }
//
// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   int? selectedIndex;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 10,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text('Item: $index'),
//           tileColor: selectedIndex == index ? Colors.blue : null,
//           onTap: () {
//             setState(() {
//               selectedIndex = index;
//             });
//           },
//         );
//       },
//     );
//   }
// }
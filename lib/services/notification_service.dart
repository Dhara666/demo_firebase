import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationService {

  FirebaseMessaging? firebaseMessaging;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log('Background message Id : ${message.messageId}');
    log('Background message Time : ${message.sentTime}');
  }

  Future<void> initializeNotification() async {
    print("--->initializeNotification");
    await Firebase.initializeApp();
    await initializeLocalNotification();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? fcmToken = await firebaseMessaging.getToken();
    log('FCM Token --> $fcmToken');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings notificationSettings =
        await firebaseMessaging.requestPermission(announcement: true);

    log('Notification permission status : ${notificationSettings.authorizationStatus.name}');
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
        log('Message title: ${remoteMessage.notification!.title}, body: ${remoteMessage.notification!.body}');

        AndroidNotificationDetails androidNotificationDetails =
            const AndroidNotificationDetails(
          'CHANNEL ID',
          'CHANNEL NAME',
          channelDescription: 'CHANNEL DESCRIPTION',
          importance: Importance.max,
          priority: Priority.max,

        );
        IOSNotificationDetails iosNotificationDetails =
            const IOSNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );
        NotificationDetails notificationDetails = NotificationDetails(
            android: androidNotificationDetails, iOS: iosNotificationDetails);
        await flutterLocalNotificationsPlugin.show(
          0,
          remoteMessage.notification!.title!,
          remoteMessage.notification!.body!,
          notificationDetails,
        );
        // controller.getNotificationCount();
        // controller.refresh();
      });
   }
  }

  static initializeLocalNotification() {
    AndroidInitializationSettings android =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings ios = const IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    InitializationSettings platform =
        InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);
  }

   sendNotification({String? body, String? title, String? token}) async {
    String baseUrl = 'https://fcm.googleapis.com/fcm/send';
    print("--->sendNotification $body");
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
        'key=AAAAXGj0Jj8:APA91bEmeROAY1_pGPqARg8ea-kBj4nEhxxMipfEc5baX-Al-rVzugKSzBYDIfXmch4tu6sWFuj2Jxvlfy6j9A8rpH0q7NMfK1lYsbXcpMcQpqR8yKzas92P__8_iAxEpytWjywy64mG',
      },
      body: jsonEncode({
        "notification": {
          "body": body,
          "title": title,
          "token": token
        },
        "priority": "high",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done",
          "open_val": "B",
        },
        "registration_ids": [token]
      }),
    );
    print('Status code : ${response.statusCode}');
    print('Body : ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var message = jsonDecode(response.body);
      return message;
    } else {
      print('Status code error : ${response.statusCode}');
    }
  }
}

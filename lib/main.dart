

import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hupr_texibooking/Screens/Announcements/announcement.dart';
import 'package:hupr_texibooking/Screens/Splash_Screen/splash_screen.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("BackgroundHandler  ${message.data}");
  await Firebase.initializeApp();
}

const AndroidNotificationChannel androidSettings = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
  void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();

      var box = GetStorage();
      //Assign publishable key to flutter_stripe
      Stripe.publishableKey =
          "pk_test_51HolFdGgnK7D16sB9X0USNo6xKPYQmm1s9xjyvwcrmfJtB2HKlpMDJVEVO2SI9edNvYLnIk9NovrBvggeFkCgqH300XXbyXWEe";
      Stripe.merchantIdentifier = 'any string works';
      await Stripe.instance.applySettings();

      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request push notification permissions
      // You can request these permissions at any point in your application.
      if (Platform.isAndroid) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(androidSettings);
      } else if (Platform.isIOS) {
        await FlutterLocalNotificationsPlugin()
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()!
            .requestPermissions(sound: true, alert: true, badge: true);
      }

    //This is used to define the initialization settings for iOS and android

      var initializationSettingsAndroid =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = const DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print('A new onMessag event was published!');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        showNotification(message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print('onMessageOpenedApp ${message.data["type"]}');
        if (message.data["type"] == "Announcement") {
          Get.to(() => Announcements());
        } else {}
      });

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.instance.getToken().then((value) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("fcm_token", value.toString());
        print('Firebase Token :-  $value');
      });

      getLocationUpdates();

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.black, // set Status bar color in Android devices
        statusBarIconBrightness:
            Brightness.light, // set Status bar icons color in Android devices
        statusBarBrightness: Brightness.light, // set Status bar icon color in iOS
      )); 
        
  runApp(GetMaterialApp(
      title: 'HUPR',
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0xFF4E204C),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          appBarTheme:
              AppBarTheme(backgroundColor: appBackgroundColor, elevation: 0)),
    ));


}

final Location locationController = Location();

 Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
       return;
    }
    permissionStatus = await locationController.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await locationController.requestPermission();
      if (permissionStatus == PermissionStatus.granted) {
        return;
      }
    }
 }
 




var notificationDetails = NotificationDetails(
  android: AndroidNotificationDetails(
    androidSettings.id,
    androidSettings.name,
    importance: Importance.high,
    color: Colors.teal,
    playSound: true,
    icon: '@mipmap/ic_launcher',
  ),
);
 showNotification(RemoteMessage message) {
    log('showNotification');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? ios = message.notification?.apple;

    if (notification != null) {
      if (Platform.isIOS) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body ,
          notificationDetails,
        );
      } else {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          notificationDetails,
        );
      }
    }
  }


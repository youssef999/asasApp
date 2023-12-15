import 'package:asas/app/helpers/sharedPref.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FcmHelper {
  // FCM Messaging
  static late FirebaseMessaging messaging;

  ///this function will initialize firebase and fcm instance
  static Future<void> initFcm() async {
    //initialize fcm and firebase core
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;

    //initialize notifications channel and libraries
    initNotification();

    //notification settings handler
    await setupFcmNotificationSettings();

    //generate token if it not already generated and store it on shared pref
    await handleFcmToken();

     //subscribe To Topic
     //await FirebaseMessaging.instance.subscribeToTopic('wafaa_notification');

    //background and foreground handlers
    FirebaseMessaging.onMessage.listen(fcmForegroundHandler);
    FirebaseMessaging.onBackgroundMessage(fcmBackgroundHandler);


  }

  ///handle fcm notification settings (sound,badge..etc)
  static Future<void> setupFcmNotificationSettings() async {
    //show notification with sound and badge
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    //NotificationSettings settings
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  ///generate and save fcm token if its not already generated (generate only for 1 time)
  static Future<void> handleFcmToken() async {
    try {
      // check if the token was already generated and saved and stop function if it is..
      String? savedToken = PreferenceUtils.getFcmToken();
      if (savedToken != null) return;

      // let fcm generate token for us
      String? token = await messaging.getToken(
        vapidKey: "BGpdLRs......",
      );

      //fail to generate token
      if (token == null) {
        //close app safely
        //SystemNavigator.pop();
        return; //stop method
      }

      Logger().i('FCM Token => $token');

      //if token was generated successfully (save it to shared pref)
      PreferenceUtils.setFcmToken(token);
    } catch (error) {
      Logger().e('Error => $error');
    }
  }

  ///handle fcm notification when app is closed/terminated
  static Future<void> fcmBackgroundHandler(RemoteMessage message) async {
    await showNotification(
      title: message.notification!.title!, // title from fcm
      body: message.notification!.body!, // body from fcm
      id: 1, // notification id
    );
  }

  //handle fcm notification when app is open
  static Future<void> fcmForegroundHandler(RemoteMessage message) async {
    Logger().e('Message from foreground => ${message.data}');
    Logger().e('Message from foreground => ${message.data}');
    await showNotification(
      title: message.notification!.title!, // title from fcm
      body: message.notification!.body!, // body from fcm
      id: 1, // notification id
    );
  }

  //display notification for user with sound
  static Future<void> showNotification({required String title, required String body, required int id}) async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      } else {
        // u can show notification
        AwesomeNotifications().createNotification(
          content: NotificationContent( 
            id: id, 
            channelKey: 'asas_channel',
            title: title,
            body: body,
          ),
        );
      }
    });
  }

  ///init notifications channels
  static initNotification() {
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      "resource://drawable/notification_logo",
      [
        NotificationChannel(
          channelGroupKey: 'asas_channel_group',
          channelKey: 'asas_channel',
          channelName: 'ASAS notifications',
          channelDescription: 'Notification channel for asas app',
       //   defaultColor: LightColors.PRIMARY_COLOR,
          ledColor: Colors.white,
          channelShowBadge: true,
        )
      ],
      debug: true,
    );
  }
}
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsServices{
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings = AndroidInitializationSettings('assets/logo.png');
  void initialiseNotifications()async{
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(String title,String body) async{
    log("im here");
    AndroidNotificationDetails androidNotificationDetails =const AndroidNotificationDetails(
        "channelId",
        "channelName",
        "channelName",
      importance: Importance.max,
      priority: Priority.high
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails
    );


   await _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);

  }
}
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:nsfkpssguncelbilgiler2022/Sabitler.dart';
import 'package:timezone/timezone.dart' as tz;

import 'guncelBildirimDetay.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    // Android initialization
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios initialization
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    // the initialization settings are initialized after they are setted
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (context) => GuncelBildirimDetay(1, 1, payload),
        ));
      }
    });
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 6);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
      print(scheduledDate.toString());
    }
    return scheduledDate;
  }

  Future<void> showNotification(int id, String title, String body) async {
    var url =
        Uri.parse('https://www.guncelkpssbilgi.com/flutter/BildirimGetir.php');

    var response =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      body = items.toString().substring(9, items.toString().length - 2);
      print(items.toString().substring(9, items.toString().length - 2));
    }

    Random rnd = new Random();
    //  body = quoteslist[rnd.nextInt(quoteslist.length - 1)];
    await flutterLocalNotificationsPlugin.periodicallyShow(
        id,
        title,
        body,
        RepeatInterval.daily,
        const NotificationDetails(
          // Android details
          android: AndroidNotificationDetails(
              'guncel_channel', 'Guncel Channel',
              channelDescription: "guncel",
              importance: Importance.max,
              priority: Priority.max),
          // iOS details

          iOS: IOSNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: body);
  }
}

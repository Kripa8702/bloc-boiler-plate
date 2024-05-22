import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_boiler_plate/constants/api_path.dart';
import 'package:bloc_boiler_plate/services/navigator_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class PushNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  static bool isOpened = false;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future initPushNotifications(BuildContext context) async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _localNotifications.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings('@drawable/ic_notification'),
          iOS: DarwinInitializationSettings()),
      onDidReceiveNotificationResponse: (NotificationResponse payload) async {
        if (payload.payload != null) {
          debugPrint('------ onSelectNotification ------ $payload');
          final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
          checkForNavigation(message);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('------ onMessageOpenedApp ------');

      checkForNavigation(message);
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      debugPrint('------ onBackgroundMessage ------');
      checkForNavigation(message);
    });

    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('------ onMessage ------');

      final notification = message.notification;
      if (notification == null) return;

      if (NavigatorService.getCurrentRoute() == message.data['tag']) {
        return;
      }

      if (Platform.isAndroid) {
        _localNotifications.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    _androidChannel.id, _androidChannel.name,
                    channelDescription: _androidChannel.description,
                    icon: '@drawable/ic_notification'),
                iOS: const DarwinNotificationDetails(
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true,
                )),
            payload: jsonEncode(message.toMap()));
      }
    });
  }

  Future<String?> initNotification(BuildContext context) async {
    String? token;
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.getToken().then((fcmToken) async {
      token = fcmToken;
      await saveToken(fcmToken ?? "", context);
    });

    initPushNotifications(context);

    return token;
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> getInitialMessage() async {
    await _firebaseMessaging.getInitialMessage().then((messgae) {
      debugPrint('------ getInitialMessage ------ ${messgae?.data}');
      if (messgae != null) {
        checkForNavigation(messgae);
      }
    });
  }

  saveToken(String token, BuildContext context) async {
    /// Add your logic here to save the token to the server
    // authCubit.updateUserFCMToken(fcmToken: token);
  }

  sendPushMessage({
    required String body,
    required String title,
    required String token,
    required String route,
    String? args,
  }) async {
    String url = ApiPath.sendNotificationUrl;
    try {
      Map<String, String> data = {
        "title": title,
        "body": body,
        "token": token,
        "route": route,
        "args": "{}",
      };

      if (args != null) {
        data['args'] = args;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode != 200) {
        debugPrint('------ ${response.body} ------');

        throw "Error while sending notification. Please try again later!";
      }
    } catch (e) {
      debugPrint('------ AuthProvider ------');
      debugPrint('------ $e ------');

      throw Exception("Error sending notification. Please try again later!");
    }
  }
}

checkForNavigation(RemoteMessage message) async {
  try {
    String? screenToNavigate = message.data['tag'];
    Map<String, dynamic>? args = {};
    if (message.data['args'] != null && message.data['args'] != "{}") {
      args = jsonDecode(message.data['args']);
    }

    debugPrint('------SCREEN :  $screenToNavigate ------');
    debugPrint('------ ARGS : $args ------');

    if (screenToNavigate == "null" ||
        screenToNavigate == null ||
        FirebaseAuth.instance.currentUser == null) {
      return;
    }

    if (screenToNavigate == NavigatorService.getCurrentRoute()) {
      return;
    }

    /// Specific cased
    if (screenToNavigate == '/landingPageScreen' && args != null) {
      NavigatorService.pushNamed('/landingPageScreen', arguments: {
        'user': args['data'],
      });
      return;
    }

    /// Other case
    else {
      NavigatorService.pushNamed(screenToNavigate, arguments: args);
      return;
    }
  } catch (e) {
    debugPrint('------ Navigation Error ------');
    debugPrint('------ $e ------');
  }
}

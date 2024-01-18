import 'dart:isolate';
import 'dart:ui';

import 'package:dish_dash/data/api/api_service.dart';
import 'package:dish_dash/data/notification/notification_helper.dart';
import 'package:dish_dash/main.dart';
import 'package:flutter/foundation.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    debugPrint("Alarm fired!");
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().getRestaurantList();
    await notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      result,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}

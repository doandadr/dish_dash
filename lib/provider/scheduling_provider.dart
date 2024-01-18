import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dish_dash/data/notification/background_service.dart';
import 'package:dish_dash/data/notification/date_time_helper.dart';
import 'package:flutter/foundation.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRestaurantNotification(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      debugPrint('Scheduling Restaurant Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      debugPrint('Scheduling Restaurant Cancelled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}

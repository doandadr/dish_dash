import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dish_dash/common/navigation.dart';
import 'package:dish_dash/data/api/api_service.dart';
import 'package:dish_dash/data/db/database_helper.dart';
import 'package:dish_dash/data/notification/background_service.dart';
import 'package:dish_dash/data/preferences/preferences_helper.dart';
import 'package:dish_dash/provider/database_provider.dart';
import 'package:dish_dash/provider/preferences_provider.dart';
import 'package:dish_dash/provider/restaurant_details_provider.dart';
import 'package:dish_dash/provider/restaurant_list_provider.dart';
import 'package:dish_dash/provider/restaurant_search_provider.dart';
import 'package:dish_dash/provider/scheduling_provider.dart';
import 'package:dish_dash/ui/detail_screen.dart';
import 'package:dish_dash/ui/home_screen.dart';
import 'package:dish_dash/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/model/restaurant.dart';
import 'data/notification/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantDetailsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantSearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance())),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
      ],
      child: Consumer<PreferencesProvider>(
        builder:
            (BuildContext context, PreferencesProvider value, Widget? child) {
          return MaterialApp(
            title: 'Dish Dash',
            theme: value.themeData,
            navigatorKey: navigatorKey,
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => const SplashScreen(),
              HomeScreen.routeName: (context) => const HomeScreen(),
              DetailScreen.routeName: (context) => DetailScreen(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant),
            },
          );
        },
      ),
    );
  }
}

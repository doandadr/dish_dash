import 'package:dish_dash/ui/detail_screen.dart';
import 'package:dish_dash/ui/home_screen.dart';
import 'package:dish_dash/common/style.dart';
import 'package:dish_dash/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'data/model/restaurant.dart';
import 'data/model/restaurant_list_result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'DMSans',
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
          onPrimary: onPrimaryColor,
          onSecondary: onSecondaryColor,
        ),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        DetailScreen.routeName: (context) => DetailScreen(
          restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant
        ),
      },
    );
  }
}
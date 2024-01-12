import 'package:dish_dash/detail_screen.dart';
import 'package:dish_dash/home_screen.dart';
import 'package:dish_dash/model/restaurant.dart';
import 'package:dish_dash/splash_screen.dart';
import 'package:dish_dash/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
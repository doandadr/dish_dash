import 'package:dish_dash/home_screen.dart';
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
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
          onPrimary: onPrimaryColor,
          onSecondary: onSecondaryColor,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/homeScreen': (context) => const HomeScreen(),
        '/detailScreen': (context) => DetailScreen(
          ModalRoute.of(context)?.settings.arguments),
        )
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:dish_dash/style.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  initState() {
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        color: primaryColor,
        child: Center(
          child: Image.asset('assets/logo.jpg'),
        ),
      ),
    );
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 1000), () {

    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}

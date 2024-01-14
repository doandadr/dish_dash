import 'package:flutter/material.dart';
import 'package:dish_dash/common/style.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash_screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        color: primaryColor,
        child: Center(
          child: Image.asset('assets/logo.jpg'),
        ),
      ),
    );
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacementNamed(context, '/homeScreen');
    });
  }
}

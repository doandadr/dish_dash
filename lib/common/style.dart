import 'package:flutter/material.dart';

const primaryColor = Color(0xffc7161c);
const primaryVariantColor = Color(0xfff04a46);
const secondaryColor = Color(0xffffbd0f);
const secondaryVariantColor = Color(0xfffe8d09);
const onPrimaryColor = Colors.white;
const onSecondaryColor = Colors.black;

const Color darkPrimaryColor = Color(0xFF000000);
const Color darkSecondaryColor = Color(0xff64ffda);

ThemeData lightTheme = ThemeData(
  fontFamily: 'DMSans',
  colorScheme: ThemeData.light().colorScheme.copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
    onPrimary: onPrimaryColor,
    onSecondary: onSecondaryColor,
    brightness: Brightness.light
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
);

ThemeData darkTheme = ThemeData(
  fontFamily: 'DMSans',
  colorScheme: ThemeData.dark().colorScheme.copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
    onPrimary: onPrimaryColor,
    onSecondary: onSecondaryColor,
    brightness: Brightness.dark,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
);
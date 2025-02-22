import 'package:flutter/material.dart';
import 'main_colors.dart';

const Color lightLightGreyColor = Color(0xFF646464);
const Color lightButtonBackgroundColor = Color(0xFF646464);
const Color lightAnimatedButtonBackgroundColor = Color(0xFF333333);

const OutlineInputBorder _lightInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF626262)),
    borderRadius: BorderRadius.all(Radius.circular(15.0)));

const OutlineInputBorder _lightErrorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.all(Radius.circular(15.0)));

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFE7E7E7),
  inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(fontSize: 15.0),
      enabledBorder: _lightInputBorder,
      border: _lightInputBorder,
      focusedBorder: _lightInputBorder,
      errorBorder: _lightErrorBorder,
      focusedErrorBorder: _lightErrorBorder),
  iconTheme: const IconThemeData(color: lightLightGreyColor),
  tabBarTheme: const TabBarTheme(unselectedLabelColor: Color(0xFF646464)),
  textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xFF333333)))),
  colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: Colors.black,
      onPrimary: Colors.black,
      secondary: Colors.red,
      onSecondary: Colors.black,
      surface: Color(0xFFD2D2D2),
      onInverseSurface: Colors.black,
      error: Colors.red,
      onError: Colors.black,
      primaryContainer: darkColor,
      onPrimaryContainer: Colors.black,
      secondaryContainer: Colors.grey,
      onSecondaryContainer: Colors.black),
);

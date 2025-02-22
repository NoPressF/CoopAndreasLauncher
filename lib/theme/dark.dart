import 'package:flutter/material.dart';
import 'main_colors.dart';

const Color darkGreyColor = Color(0xFFBFC8CA);
const Color darkButtonBackgroundColor = Color(0xFFD7D7D7);
const Color darkAnimatedButtonBackgroundColor = Color(0xFFCBCBCB);

const OutlineInputBorder darkInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(15.0)));

const OutlineInputBorder darkErrorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.all(Radius.circular(15.0)));

final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF121212),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
    inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(fontSize: 15.0),
        enabledBorder: darkInputBorder,
        border: darkInputBorder,
        focusedBorder: darkInputBorder,
        errorBorder: darkErrorBorder,
        focusedErrorBorder: darkErrorBorder),
    tabBarTheme: const TabBarTheme(unselectedLabelColor: darkGreyColor),
    textButtonTheme: const TextButtonThemeData(
        style:
            ButtonStyle(backgroundColor: WidgetStatePropertyAll(darkButtonBackgroundColor))),
    dialogTheme: const DialogTheme(backgroundColor: darkColor),
    colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.red,
        onSecondary: Colors.black,
        surface: darkColor,
        onSurface: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        primaryContainer: darkColor,
        onPrimaryContainer: Colors.white,
        secondaryContainer: Colors.grey,
        onSecondaryContainer: Colors.black));

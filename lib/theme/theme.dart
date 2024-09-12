import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    primary: Colors.black,
    secondary: Color.fromARGB(255, 199, 199, 199),
    onSecondary: Color.fromARGB(255, 235, 235, 235),
    tertiary: Colors.black,
    onTertiary: Color.fromARGB(255, 188, 188, 188),
  ), // ColorScheme.light
); // ThemeData

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Colors.black,
    onPrimary: Color.fromARGB(255, 20, 20, 20),
    primary: Colors.white,
    secondary: Color.fromARGB(255, 26, 26, 26),
    onSecondary: Color.fromARGB(255, 40, 40, 40),
    tertiary: Color.fromARGB(255, 49, 49, 49),
    onTertiary: Color.fromARGB(255, 50, 50, 50),
  ), // ColorScheme.dark
); // ThemeData
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Color.fromARGB(255, 0, 0, 0),
    primary: Color.fromARGB(255, 0, 0, 0),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color.fromARGB(255, 169, 169, 169),
    onSecondary: Color.fromARGB(255, 0, 0, 0),
    tertiary: Color.fromARGB(255, 255, 255, 255),
    onTertiary: Color.fromARGB(255, 255, 255, 255)
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
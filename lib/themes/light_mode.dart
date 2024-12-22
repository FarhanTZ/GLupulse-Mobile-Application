import 'package:flutter/material.dart';

// Light Mode Theme
ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.blue.shade400,
    secondary: Colors.blue.shade200,
    tertiary: Colors.blue.shade50,
    inversePrimary: Colors.blue.shade800,
  ),
  scaffoldBackgroundColor: Colors.white,
);

// Dark Mode Theme
ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,  // Dark surface color
    primary: Colors.blue.shade700,  // Darker blue for primary
    secondary: Colors.blue.shade500,  // Lighter blue for secondary
    tertiary: Colors.blue.shade300,  // Even lighter blue
    inversePrimary: Colors.blue.shade100,  // Lighter shade for inverse primary
  ),
  scaffoldBackgroundColor: Colors.black,  // Dark background color
);

import 'package:bluetick/Screens/mainpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.system, // Follow device theme
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.light(
            primary: Color(0xFF4682FF), // Blue for buttons and accents
            onPrimary: Colors.white, // Text on primary (e.g., button text)
            background: Colors.white, // App background
            onBackground: Colors.black, // Normal text on background
            surface: Colors.grey[100]!, // Container backgrounds
            onSurface: Colors.black, // Text on containers
            onSurfaceVariant: Colors.grey[600]!, // Secondary text
          ),
          textTheme: TextTheme(
            headlineLarge: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Title text
            ),
            bodyMedium: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black, // Button text
            ),
            bodySmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black, // Normal text
            ),
          ),
          scaffoldBackgroundColor: Colors.white, // Default Scaffold background
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.dark(
            primary: Color(0xFF4682FF), // Same blue for consistency
            onPrimary: Colors.white, // Text on primary
            background: Colors.black, // App background
            onBackground: Colors.white, // Normal text on background
            surface: Colors.grey[900]!, // Container backgrounds
            onSurface: Colors.white, // Text on containers
            onSurfaceVariant: Colors.grey[400]!, // Secondary text
          ),
          textTheme: TextTheme(
            headlineLarge: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Title text
            ),
            bodyMedium: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white, // Button text
            ),
            bodySmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white, // Normal text
            ),
          ),
          scaffoldBackgroundColor: Colors.black, // Default Scaffold background
        ),
        home: MainPage());
  }
}

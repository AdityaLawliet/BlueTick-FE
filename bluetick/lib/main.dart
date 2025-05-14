import 'package:bluetick/Screens/home_screen.dart';
import 'package:bluetick/Screens/mainpage.dart';
import 'package:bluetick/token_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<Widget> _getInitialScreen() async {
    final token = await TokenManager.getToken();
    return token != null ? HomeScreen() : MainPage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: Color(0xFF4682FF),
          onPrimary: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.grey[100]!,
          onSurface: Colors.black,
          onSurfaceVariant: Colors.grey[600]!,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headlineMedium: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF4682FF),
          onPrimary: Colors.white,
          background: Colors.black,
          onBackground: Colors.white,
          surface: Colors.grey[900]!,
          onSurface: Colors.white,
          onSurfaceVariant: Colors.grey[400]!,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: FutureBuilder<Widget>(
        future: _getInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.data!;
        },
      ),
    );
  }
}

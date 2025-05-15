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
          primary: Color(0xFF4682FF), // Blue
          onPrimary: Colors.white,
          secondary: Color(0xFF80A8FF), // Lighter blue
          onSecondary: Colors.white,
          tertiary: Color(0xFFFF8C00), // Orange
          onTertiary: Colors.white,
          background: Colors.grey[50]!, // Off-white for depth
          onBackground: Colors.grey[900]!, // Softer than black
          surface: Colors.grey[100]!, // Consistent with cards
          onSurface: Colors.grey[900]!, // Softer than black
          onSurfaceVariant: Colors.grey[600]!,
          error: Colors.redAccent,
          onError: Colors.white,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900]!, // Softer black
          ),
          displayMedium: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900]!,
          ),
          headlineLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900]!,
          ),
          headlineMedium: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900]!,
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.grey[900]!,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey[900]!,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[900]!,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.grey[900]!,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[900]!,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[900]!,
          ),
          labelMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[50]!, // Off-white for depth
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[100]!, // Slightly tinted white
          foregroundColor: Colors.grey[800]!, // Darker for contrast
          elevation: 2, // Subtle shadow for depth
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4682FF),
          ),
          iconTheme: IconThemeData(color: Color(0xFF4682FF)), // Darker icons
          actionsIconTheme:
              IconThemeData(color: Color(0xFF4682FF)), // Darker actions
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4682FF),
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFF80A8FF),
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Color(0xFF4682FF),
            side: BorderSide(color: Color(0xFF4682FF), width: 1.5),
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF4682FF), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.redAccent, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.redAccent, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIconColor: Color(0xFF80A8FF),
          suffixIconColor: Color(0xFF80A8FF),
        ),
        cardTheme: CardTheme(
          color: Colors.grey[50]!, // Off-white for cards
          elevation: 4,
          shadowColor: Colors.grey.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        dividerTheme: DividerThemeData(
          color: Colors.grey[300],
          thickness: 1,
          space: 16,
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF7B61FF),
          size: 24,
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.grey[100]!, // Light grey for distinction
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900]!, // Softer black
          ),
          contentTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey[900]!,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.grey[800],
          contentTextStyle: TextStyle(color: Colors.white),
          actionTextColor: Color(0xFF4682FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          behavior: SnackBarBehavior.floating,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Color(0xFF80A8FF);
            }
            return Colors.grey[300];
          }),
          checkColor: WidgetStateProperty.all(Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Color(0xFF80A8FF);
            }
            return Colors.grey[400];
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Color(0xFF80A8FF).withOpacity(0.5);
            }
            return Colors.grey[300];
          }),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFF8C00),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          iconSize: 28,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[50]!, // Match scaffold
          selectedItemColor: Color(0xFF4682FF),
          unselectedItemColor: Colors.grey[600],
          selectedIconTheme: IconThemeData(color: Color(0xFF4682FF), size: 28),
          unselectedIconTheme: IconThemeData(color: Colors.grey[600], size: 24),
          selectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Color(0xFF4682FF),
          unselectedLabelColor: Colors.grey[600],
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Color(0xFF80A8FF), width: 3),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: Color(0xFF4682FF),
          inactiveTrackColor: Colors.grey[300],
          thumbColor: Color(0xFF80A8FF),
          overlayColor: Color(0xFF4682FF).withOpacity(0.2),
          activeTickMarkColor: Colors.white,
          inactiveTickMarkColor: Colors.grey[400],
          valueIndicatorColor: Color(0xFF4682FF),
          valueIndicatorTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Color(0xFF4682FF),
          linearTrackColor: Colors.grey[300],
          circularTrackColor: Colors.grey[300],
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey[100],
          selectedColor: Color(0xFF80A8FF),
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(
            color: Colors.grey[900]!,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          secondaryLabelStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey[300]!),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF4682FF),
          onPrimary: Colors.white,
          secondary: Color(0xFF80A8FF),
          onSecondary: Colors.white,
          tertiary: Color(0xFFFF8C00),
          onTertiary: Colors.white,
          background: Colors.black,
          onBackground: Colors.white,
          surface: Colors.grey[900]!,
          onSurface: Colors.white,
          onSurfaceVariant: Colors.grey[400]!,
          error: Colors.redAccent,
          onError: Colors.white,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
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
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          labelMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[400],
          ),
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4682FF),
          ),
          iconTheme: IconThemeData(color: Color(0xFF4682FF)),
          actionsIconTheme: IconThemeData(color: Color(0xFF4682FF)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4682FF),
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFF80A8FF),
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Color(0xFF4682FF),
            side: BorderSide(color: Color(0xFF4682FF), width: 1.5),
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[800],
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[700]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF4682FF), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.redAccent, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.redAccent, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.grey[400]),
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIconColor: Color(0xFF80A8FF),
          suffixIconColor: Color(0xFF80A8FF),
        ),
        cardTheme: CardTheme(
          color: Colors.grey[850],
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        dividerTheme: DividerThemeData(
          color: Colors.grey[700],
          thickness: 1,
          space: 16,
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF7B61FF),
          size: 24,
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          contentTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.grey[900],
          contentTextStyle: TextStyle(color: Colors.white),
          actionTextColor: Color(0xFF4682FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          behavior: SnackBarBehavior.floating,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Color(0xFF80A8FF);
            }
            return Colors.grey[700];
          }),
          checkColor: WidgetStateProperty.all(Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Color(0xFF80A8FF);
            }
            return Colors.grey[600];
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Color(0xFF80A8FF).withOpacity(0.5);
            }
            return Colors.grey[700];
          }),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFF8C00),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          iconSize: 28,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[900],
          selectedItemColor: Color(0xFF4682FF),
          unselectedItemColor: Colors.grey[400],
          selectedIconTheme: IconThemeData(color: Color(0xFF4682FF), size: 28),
          unselectedIconTheme: IconThemeData(color: Colors.grey[400], size: 24),
          selectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Color(0xFF4682FF),
          unselectedLabelColor: Colors.grey[400],
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Color(0xFF80A8FF), width: 3),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: Color(0xFF4682FF),
          inactiveTrackColor: Colors.grey[700],
          thumbColor: Color(0xFF80A8FF),
          overlayColor: Color(0xFF4682FF).withOpacity(0.2),
          activeTickMarkColor: Colors.white,
          inactiveTickMarkColor: Colors.grey[500],
          valueIndicatorColor: Color(0xFF4682FF),
          valueIndicatorTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Color(0xFF4682FF),
          linearTrackColor: Colors.grey[700],
          circularTrackColor: Colors.grey[700],
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey[800],
          selectedColor: Color(0xFF80A8FF),
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          secondaryLabelStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey[700]!),
          ),
        ),
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

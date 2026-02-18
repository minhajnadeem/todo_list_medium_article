import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/todo_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // CONCEPT 2: ChangeNotifierProvider
    // ---------------------------------
    // We wrap the app (or the subtree that needs the state) with
    // ChangeNotifierProvider. This "provides" our TodoProvider to all
    // descendants. Any child can now access it via Provider.of<TodoProvider>
    // or the Consumer widget.
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: MaterialApp(
        title: 'Todo with Provider',
        theme: _buildLightTheme(),
        darkTheme: _buildDarkTheme(),
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      ),
    );
  }
}

// Light theme: primary #2f9983, background #f7f0f0
ThemeData _buildLightTheme() {
  const primary = Color(0xFF2F9983);
  const background = Color(0xFFF7F0F0);
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: primary,
      background: background,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
    ),
  );
}

// Dark theme: primary #1b3956, dark background and readable text
ThemeData _buildDarkTheme() {
  const primary = Color(0xFF1B3956);
  const background = Color(0xFF0D1117);
  const surface = Color(0xFF161B22);
  const onPrimary = Color(0xFFE6EDF3);
  const onBackground = Color(0xFFE6EDF3);
  const onSurface = Color(0xFFE6EDF3);
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      onPrimary: onPrimary,
      secondary: primary,
      onSecondary: onPrimary,
      surface: surface,
      onSurface: onSurface,
      background: background,
      onBackground: onBackground,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: onPrimary,
      centerTitle: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: onPrimary,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: onPrimary,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: onSurface),
      bodyMedium: TextStyle(color: onSurface),
      bodySmall: TextStyle(color: onSurface),
      titleLarge: TextStyle(color: onSurface),
      titleMedium: TextStyle(color: onSurface),
      titleSmall: TextStyle(color: onSurface),
      labelLarge: TextStyle(color: onSurface),
      labelMedium: TextStyle(color: onSurface),
      labelSmall: TextStyle(color: onSurface),
    ),
  );
}

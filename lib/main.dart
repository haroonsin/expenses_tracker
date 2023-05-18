import 'package:expenses_tracker/widget/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  var kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 96, 59, 181),
  );

  var kColorDarkScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 5, 99, 125),
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kColorDarkScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorDarkScheme.primaryContainer,
            foregroundColor: kColorDarkScheme.onPrimaryContainer,
          ),
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorDarkScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        // scaffoldBackgroundColor: const Color.fromARGB(255, 134, 83, 147),
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              // titleLarge: ThemeData().textTheme.titleLarge.copyWith(),
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 14,
              ),
            ),
      ),
      themeMode: ThemeMode.dark,
      home: const Expenses(),
    );
  }
}

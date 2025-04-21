import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFFFB962B),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFB962B),
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    fontFamily: 'Cairo',
  );
}

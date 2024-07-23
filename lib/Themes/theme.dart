import 'package:flutter/material.dart';

ThemeData _buildThemeData() {
  return ThemeData(
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      displaySmall: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );
}

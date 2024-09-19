import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier{

  ThemeMode _themeMode = ThemeMode.light;
  bool isDark = false;

  void toggleTheme(bool isDark){
   _themeMode = isDark?ThemeMode.dark:ThemeMode.light;
   notifyListeners();
  }

  ThemeMode get themeMode => themeMode;

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(primary: Colors.purple, onPrimary: Colors.white)
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(primary: Colors.purple,onPrimary: Colors.white)
  );
}
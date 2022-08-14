import 'package:flutter/material.dart';
import 'package:my_todo_app/shared/my_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProviderApp extends ChangeNotifier {
  String AppLanguage = 'en';
  ThemeMode themeMode = ThemeMode.dark;

  void changeLanguage(String languageCode) async{
    final prefs = await SharedPreferences.getInstance();
    AppLanguage = languageCode;
    await prefs.setString('Language', languageCode);
    notifyListeners();
  }

  void changeTheme(ThemeMode theme) async{
    final prefs = await SharedPreferences.getInstance();
    themeMode = theme;
    await prefs.setString('Theme',theme==ThemeMode.light?'light':'dark');
    notifyListeners();
  }

  // String getBackground() {
  //   if (themeMode == ThemeMode.light) {
  //
  //     return 'assets/images/default_bg.png';
  //   } else {
  //     return 'assets/images/dark_bg.png';
  //   }
  // }

  Color BottonColer() {
    if (themeMode == ThemeMode.light) {
      return Color(0xFFFFFFFF);
    } else {
      return Color(0xF9000000);
    }
  }
  Color reversBottonColer() {
    if (themeMode != ThemeMode.light) {
      return Color(0xFFFFFFFF);
    } else {
      return Color(0xF9000000);
    }
  }
  Color ScaffoldColer() {
    if (themeMode == ThemeMode.light) {
      return MyThemeData.OnprimaryColor;
    } else {
      return MyThemeData.DarkOnprimaryColor;
    }
  }
}
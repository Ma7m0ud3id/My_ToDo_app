import 'package:flutter/material.dart';

class MyProviderApp extends ChangeNotifier {

  String AppLanguage = 'en';
  ThemeMode themeMode = ThemeMode.dark;

  void changeLanguage(String languageCode) {
    AppLanguage = languageCode;
    notifyListeners();
  }

  void changeTheme(ThemeMode theme) {
    themeMode = theme;
    notifyListeners();
  }

  String getBackground() {
    if (themeMode == ThemeMode.light) {
      return 'assets/images/default_bg.png';
    } else {
      return 'assets/images/dark_bg.png';
    }
  }

  Color BottonColer() {
    if (themeMode == ThemeMode.light) {
      return Color(0xFFB7935F);
    } else {
      return Color(0xFFCBC202);
    }
  }
}
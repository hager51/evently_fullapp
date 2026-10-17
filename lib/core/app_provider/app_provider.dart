import 'package:flutter/material.dart';

class AppProvider  extends ChangeNotifier{


  ThemeMode themeMode = ThemeMode.light;

  String locale = "en";


  void changeTheme(ThemeMode theme){
    themeMode = theme;
    notifyListeners();
  }

  void changeLocale(String loc){
    locale = loc;
    notifyListeners();
  }





}
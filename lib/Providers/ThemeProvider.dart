import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{

  var primaryColor = Colors.deepPurple;
  var accentColor = Colors.amber;

  var themeMode = ThemeMode.system;
  String themeText = 's';


  onChange(newColor,n)async{
    n==1
        ? primaryColor = _toMaterialColor(newColor.hashCode)
        :accentColor = _toMaterialColor(newColor.hashCode);

    notifyListeners();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("primaryColor", primaryColor.value);
    preferences.setInt("accentColor", accentColor.value);
  }
  
  getThemeColors()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

    primaryColor = _toMaterialColor(preferences.getInt("primaryColor")?? 0xFF673AB7);
    accentColor = _toMaterialColor(preferences.getInt("accentColor")?? 0xFFFFC107);

    notifyListeners();
  }

  MaterialColor _toMaterialColor(colorVal){
    return MaterialColor(colorVal,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(colorVal),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),

    });
  }

  void themeModeChange(newThemeVal)async{
    themeMode = newThemeVal;
    _getThemeText(themeMode);
    notifyListeners();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("themeText", themeText);
  }

  _getThemeText(ThemeMode themeMode){
    if(themeMode == ThemeMode.dark)
      themeText = "d";
    else if(themeMode == ThemeMode.light)
      themeText ="l";
    else if(themeMode == ThemeMode.system)
      themeText ="s";
  }

  getThemeMode()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
     themeText = preferences.getString("themeText") ?? "s" ;
    if(themeText == "d")
      themeMode = ThemeMode.dark;
    else if(themeText == "l")
    themeMode = ThemeMode.light;
    else if(themeText == "s")
      themeMode = ThemeMode.system;

    notifyListeners();

  }
}
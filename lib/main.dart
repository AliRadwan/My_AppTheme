import 'package:flutter/material.dart';
import 'package:my_theme/Providers/ThemeProvider.dart';
import 'package:provider/provider.dart';

import 'ThemeScreen.dart';

void main() {
  
  runApp(MultiProvider(
    providers: [
      
      ChangeNotifierProvider<ThemeProvider>(create: (ctx)=> ThemeProvider())
    ],
      
      child: MyApp()));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    Provider.of<ThemeProvider>(context,listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context,listen: false).getThemeColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var primaryColor = Provider.of<ThemeProvider>(context,listen: true).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context,listen: true).accentColor;
    var themeMode = Provider.of<ThemeProvider>(context,listen: true).themeMode;

    return MaterialApp(
      title: "flutter Demo",
      themeMode: themeMode,
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(color: Color.fromRGBO(20, 50, 50, 1))
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor:Colors.black,
          primaryColor: primaryColor,
          accentColor: accentColor,
          unselectedWidgetColor: Colors.white70,
          textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 50, 50, 1))
          ),
        buttonColor: Colors.white70
      ),
      home: ThemeScreen(),
    );
  }
}




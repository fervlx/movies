import 'package:flutter/material.dart';

class AppTheme {

  static const Color primary = Colors.pink;

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      elevation: 0.0,
    )
  );

  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    splashColor: primary,
    //brightness: primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white
      ),
    )
  );


  static TextTheme textTheme(  BuildContext context ) => Theme.of( context ).textTheme;
}
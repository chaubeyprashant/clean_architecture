import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Muli',
      appBarTheme: appBarTheme(),
      textTheme: customTextTheme);
}

const customTextTheme = TextTheme(
  displayLarge: TextStyle(
      fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
  displayMedium: TextStyle(
      fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
  bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
  bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black54),
  titleMedium: TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
  bodySmall: TextStyle(fontSize: 12.0, color: Colors.red),
);

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0XFF8B8B8B)),
    titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  );
}

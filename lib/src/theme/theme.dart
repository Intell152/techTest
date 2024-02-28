import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF02284E),
    actionsIconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF011B34),
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.white,
  ),
  scaffoldBackgroundColor: const Color(0xFF011B34),
  cardTheme: const CardTheme(color: Color(0xFF042C4C)),
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFF204c94),
    selectionColor: Color.fromARGB(255, 5, 75, 187),
    selectionHandleColor: Color(0xFF204c94),
  ),
  cardColor: const Color(0xFF02284E),
);

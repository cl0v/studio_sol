import 'package:flutter/material.dart';

/// Tema claro da aplicação
final themeLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.pink[500],
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.grey[350],
      padding: EdgeInsets.symmetric(horizontal: 16),
      onPrimary: Colors.black,
      textStyle: TextStyle(fontWeight: FontWeight.bold)
    ),
  ),
);

/// Tema escuro da aplicação
final themeDark = ThemeData(
  brightness: Brightness.dark,
);

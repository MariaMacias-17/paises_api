import 'package:flutter/material.dart';

// el tema oscuro de toda la app, asi no tengo que poner colores en cada widget
class AppTheme {
  static const Color fondo = Color(0xFF0E1116);
  static const Color superficie = Color(0xFF181C23);
  static const Color superficieAlta = Color(0xFF222833);
  static const Color acento = Color(0xFF5EEAD4);
  static const Color textoSecundario = Color(0xFF9AA4B2);

  // tema que se le pasa al MaterialApp en main.dart
  static ThemeData get oscuro => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: fondo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: acento,
      brightness: Brightness.dark,
      primary: acento,
      surface: superficie,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: fondo,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    cardTheme: CardThemeData(
      color: superficie,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
      ),
    ),
  );
}

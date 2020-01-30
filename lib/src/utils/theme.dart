import 'package:flutter/material.dart';

const int mainColor = 0xFFc62dba;

ThemeData getGolbalTheme(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  final theme = ThemeData(
    brightness: Brightness.light,
    accentColor: Color(mainColor),
    primaryColor: Color(mainColor),
    backgroundColor: Colors.grey[300],
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Colors.grey[300],
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: Colors.grey[800],
      ),
    ),
    fontFamily: 'FiraSans',
    textTheme: TextTheme(
      body1: textTheme.body1.copyWith(
        fontFamily: 'FiraSans',
      ),
      title: textTheme.title.copyWith(
        fontFamily: 'FiraSansCondensed',
        fontWeight: FontWeight.w300,
        fontSize: 24.0,
        color: Colors.grey[800],
      ),
      subtitle: textTheme.subtitle.copyWith(
        fontFamily: 'FiraSansCondensed',
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        color: Colors.grey[800],
        fontSize: 26.0,
      ),
    ),
  );

  return theme;
}

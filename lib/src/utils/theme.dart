import 'package:flutter/material.dart';

const int mainColor = 0xFFc62dba;
const int backgroundColor = 0xFFE0E0E0;
const int mainFontColor = 0xFF424242;

ThemeData getGolbalTheme(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  final theme = ThemeData(
    brightness: Brightness.light,
    accentColor: Color(mainColor),
    primaryColor: Color(mainColor),
    backgroundColor: const Color(backgroundColor),
    scaffoldBackgroundColor: const Color(backgroundColor),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: const Color(backgroundColor),
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: const Color(mainFontColor),
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
        color: const Color(mainFontColor),
      ),
      subtitle: textTheme.subtitle.copyWith(
        fontFamily: 'FiraSansCondensed',
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        color: const Color(mainFontColor),
        fontSize: 20.0,
      ),
    ),
  );

  return theme;
}

BoxDecoration tileDecoration = BoxDecoration(
  color: const Color(backgroundColor),
  borderRadius: BorderRadius.circular(7.0),
  border: Border.all(
    width: 1.0,
    color: Colors.grey[100],
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.grey[500],
      offset: Offset(5.0, 5.0),
      blurRadius: 15.0,
      spreadRadius: 1.0,
    ),
    BoxShadow(
      color: Colors.white,
      offset: Offset(-5.0, -5.0),
      blurRadius: 15.0,
      spreadRadius: 1.0,
    ),
  ],
);

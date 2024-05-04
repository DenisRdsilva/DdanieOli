import 'dart:ui';

import 'package:flutter/material.dart';

import '../app/views/galeries/galeries_view.dart';
import '../app/views/home/home_view.dart';
import '../erro404.dart';

const Color primary = Colors.white;
const Color onPrimary = Colors.black;
const Color secondary = Color.fromRGBO(85, 85, 85, 1);
const Color onSecondary = Colors.transparent;
const Color terciary = Color.fromRGBO(55, 55, 55, 1);
const Color error = Colors.red;
const Color onError = Colors.redAccent;
const Color surface = Color.fromRGBO(38, 38, 38, 1);
const Color modalBackground = Color.fromRGBO(1, 5, 9, 0.898);
const Color onSurface = Colors.black;
const Color borderInput = Color.fromARGB(158, 225, 225, 225);
const Color textFieldBackground = Color.fromARGB(255, 248, 248, 248);

const LinearGradient gradientColor = LinearGradient(
    begin: Alignment.topLeft,
    colors: [Color.fromARGB(255, 150, 144, 144), Colors.blue]);

const TextTheme textTheme = TextTheme(
  titleLarge: TextStyle(
      fontFamily: 'Saira',
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: primary),
  titleMedium: TextStyle(
      fontFamily: 'Saira',
      color: Color.fromARGB(255, 188, 188, 188),
      fontSize: 20),
  titleSmall: TextStyle(
      fontFamily: 'Saira',
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20),
  headlineLarge: TextStyle(
      fontFamily: 'Saira',
      color: primary,
      fontSize: 14,
      fontWeight: FontWeight.bold),
  headlineMedium:
      TextStyle(fontFamily: 'Saira', color: Colors.black, fontSize: 16),
  headlineSmall: TextStyle(
      fontFamily: 'Saira',
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold),
  labelLarge: TextStyle(
      fontFamily: 'Saira',
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 36),
  labelMedium: TextStyle(
    fontFamily: 'Saira',
    color: Colors.white,
    fontSize: 14,
    shadows: [
      Shadow(
        offset: Offset(1, 1),
        color: Color.fromRGBO(0, 0, 0, 0.5),
      )
    ],
  ),
  labelSmall: TextStyle(fontFamily: 'Saira', color: primary, fontSize: 14),
  bodyLarge: TextStyle(
      fontFamily: 'Saira',
      color: primary,
      fontWeight: FontWeight.bold,
      fontSize: 18),
  bodyMedium: TextStyle(
      fontFamily: 'Saira',
      color: primary,
      fontWeight: FontWeight.bold,
      fontSize: 16),
  bodySmall: TextStyle(fontFamily: 'Saira', color: primary, fontSize: 14),
  displayLarge:
      TextStyle(fontFamily: 'Saira', fontSize: 30, color: Colors.white),
  displayMedium:
      TextStyle(fontFamily: 'Saira', fontSize: 20, color: Colors.white),
  displaySmall: TextStyle(fontFamily: 'Saira', color: onPrimary, fontSize: 14),
);

final MaterialApp appMaterial = MaterialApp(
  theme: ThemeData(
      menuButtonTheme: MenuButtonThemeData(
          style: ButtonStyle(
        overlayColor: const MaterialStatePropertyAll(surface),
        foregroundColor: const MaterialStatePropertyAll(primary),
        textStyle: MaterialStatePropertyAll(textTheme.bodyMedium),
      )),
      menuBarTheme: const MenuBarThemeData(
          style: MenuStyle(
              // padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 18, vertical: 15)),
              elevation: MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(secondary),
              shape: MaterialStatePropertyAll(
                  BeveledRectangleBorder(borderRadius: BorderRadius.zero)))),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        backgroundColor: const MaterialStatePropertyAll(primary),
        foregroundColor: const MaterialStatePropertyAll(onPrimary),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(10)),
        textStyle: MaterialStatePropertyAll(textTheme.bodyMedium),
        overlayColor: const MaterialStatePropertyAll(textFieldBackground),
      )),
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
              elevation: MaterialStatePropertyAll(4),
              shape: MaterialStatePropertyAll(CircleBorder(eccentricity: 1)))),
      useMaterial3: true,
      fontFamily: 'Saira',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: primary,
      splashColor: onPrimary,
      disabledColor: secondary,
      // hoverColor: Colors.black,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        error: error,
        onError: onError,
        surface: surface,
        background: surface,
        onBackground: onSurface,
        onSurface: onSurface,
      ),
      textTheme: textTheme),
  debugShowCheckedModeBanner: false,
  title: 'DanielOli',
  home: const HomePage(),
  initialRoute: '/',
  routes: {
    '/galerias': (context) => const GaleriesPage(),
  },
  onGenerateRoute: (settings) {
    if (settings.name == null) {
      return null;
    }

    final routeName = settings.name!;

    WidgetBuilder builder;
    switch (routeName) {
      default:
        builder = (context) => const ErrorPage();
    }

    return MaterialPageRoute(builder: builder, settings: settings);
  },
  onUnknownRoute: (settings) =>
      MaterialPageRoute(builder: (_) => const ErrorPage()),
  navigatorKey: GlobalKey(),
);

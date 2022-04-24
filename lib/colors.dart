
import 'package:flutter/material.dart';
const int _mainColor = 0xFF000000;
const int _backgroundColor =  0xFF000000;
const int _upperButtonSelectedTextColor = 0xFFFFC300;
const int _upperButtonDeselectedTextColor = 0xFF273746; //
const int _upperButtonSelectedColor = 0xFF000000;
const int _upperButtonDeselectedColor = 0xFF626567; //
const int _textColor = 0xFFFFC300;

const int _buttonTextColor = 0xFF000000;
const int _buttonColor = 0xFFFFC300;
class CoolColors {
  static const MaterialColor buttonTextColor = MaterialColor(
    _buttonTextColor,
    <int, Color>{
      50: Color(_buttonTextColor),
      100: Color(_buttonTextColor),
      200: Color(_buttonTextColor),
      300: Color(_buttonTextColor),
      400: Color(_buttonTextColor),
      500: Color(_buttonTextColor),
      600: Color(_buttonTextColor),
      700: Color(_buttonTextColor),
      800: Color(_buttonTextColor),
      900: Color(_buttonTextColor),
    },
  );
  static const MaterialColor buttonColor = MaterialColor(
    _buttonColor,
    <int, Color>{
      50: Color(_buttonColor),
      100: Color(_buttonColor),
      200: Color(_buttonColor),
      300: Color(_buttonColor),
      400: Color(_buttonColor),
      500: Color(_buttonColor),
      600: Color(_buttonColor),
      700: Color(_buttonColor),
      800: Color(_buttonColor),
      900: Color(_buttonColor),
    },
  );
  static const MaterialColor upperButtonDeselectedColor = MaterialColor(
    _upperButtonDeselectedColor,
    <int, Color>{
      50: Color(_upperButtonDeselectedColor),
      100: Color(_upperButtonDeselectedColor),
      200: Color(_upperButtonDeselectedColor),
      300: Color(_upperButtonDeselectedColor),
      400: Color(_upperButtonDeselectedColor),
      500: Color(_upperButtonDeselectedColor),
      600: Color(_upperButtonDeselectedColor),
      700: Color(_upperButtonDeselectedColor),
      800: Color(_upperButtonDeselectedColor),
      900: Color(_upperButtonDeselectedColor),
    },
  );
  static const MaterialColor upperButtonSelectedColor = MaterialColor(
    _upperButtonSelectedColor,
    <int, Color>{
      50: Color(_upperButtonSelectedColor),
      100: Color(_upperButtonSelectedColor),
      200: Color(_upperButtonSelectedColor),
      300: Color(_upperButtonSelectedColor),
      400: Color(_upperButtonSelectedColor),
      500: Color(_upperButtonSelectedColor),
      600: Color(_upperButtonSelectedColor),
      700: Color(_upperButtonSelectedColor),
      800: Color(_upperButtonSelectedColor),
      900: Color(_upperButtonSelectedColor),
    },
  );
  static const MaterialColor textColor = MaterialColor(
    _textColor,
    <int, Color>{
      50: Color(_textColor),
      100: Color(_textColor),
      200: Color(_textColor),
      300: Color(_textColor),
      400: Color(_textColor),
      500: Color(_textColor),
      600: Color(_textColor),
      700: Color(_textColor),
      800: Color(_textColor),
      900: Color(_textColor),
    },
  );
  static const MaterialColor upperButtonDeselectedTextColor = MaterialColor(
    _upperButtonDeselectedTextColor,
    <int, Color>{
      50: Color(_upperButtonDeselectedTextColor),
      100: Color(_upperButtonDeselectedTextColor),
      200: Color(_upperButtonDeselectedTextColor),
      300: Color(_upperButtonDeselectedTextColor),
      400: Color(_upperButtonDeselectedTextColor),
      500: Color(_upperButtonDeselectedTextColor),
      600: Color(_upperButtonDeselectedTextColor),
      700: Color(_upperButtonDeselectedTextColor),
      800: Color(_upperButtonDeselectedTextColor),
      900: Color(_upperButtonDeselectedTextColor),
    },
  );
  static const MaterialColor backgroundColor = MaterialColor(
    _backgroundColor,
    <int, Color>{
      50: Color(_backgroundColor),
      100: Color(_backgroundColor),
      200: Color(_backgroundColor),
      300: Color(_backgroundColor),
      400: Color(_backgroundColor),
      500: Color(_backgroundColor),
      600: Color(_backgroundColor),
      700: Color(_backgroundColor),
      800: Color(_backgroundColor),
      900: Color(_backgroundColor),
    },
  );
  static const MaterialColor upperButtonSelectedTextColor = MaterialColor(
    _upperButtonSelectedTextColor,
    <int, Color>{
      50: Color(_upperButtonSelectedTextColor),
      100: Color(_upperButtonSelectedTextColor),
      200: Color(_upperButtonSelectedTextColor),
      300: Color(_upperButtonSelectedTextColor),
      400: Color(_upperButtonSelectedTextColor),
      500: Color(_upperButtonSelectedTextColor),
      600: Color(_upperButtonSelectedTextColor),
      700: Color(_upperButtonSelectedTextColor),
      800: Color(_upperButtonSelectedTextColor),
      900: Color(_upperButtonSelectedTextColor),
    },
  );
  static const MaterialColor mainColor = MaterialColor(
    _mainColor,
    <int, Color>{
      50: Color(_mainColor),
      100: Color(_mainColor),
      200: Color(_mainColor),
      300: Color(_mainColor),
      400: Color(_mainColor),
      500: Color(_mainColor),
      600: Color(_mainColor),
      700: Color(_mainColor),
      800: Color(_mainColor),
      900: Color(_mainColor),
    },
  );
}

MaterialColor getColor(int _Color){
  return MaterialColor(
    _Color,
    <int, Color>{
      50: Color(_Color),
      100: Color(_Color),
      200: Color(_Color),
      300: Color(_Color),
      400: Color(_Color),
      500: Color(_Color),
      600: Color(_Color),
      700: Color(_Color),
      800: Color(_Color),
      900: Color(_Color),
    },
  );
}
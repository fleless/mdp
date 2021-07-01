import 'package:flutter/material.dart';

/// This class provides custom colors to be used in the project.
///
class AppColors {
  AppColors._();

  static const Color md_dark_blue = Color(0xFF005FAA);
  static const Color md_light_gray = Color(0xFFF7F9FA);
  static const Color placeHolder = Color(0xFFB5BFC5);
  static const Color md_text_light = Color(0xFF6B808B);
  static const Color md_dark = Color(0xFF444444);
  static const Color md_tertiary = Color(0xFF627DF3);

  static const Color defaultColor = Color(0xFFd30b7a);
  static const Color appBackground = Color(0xFFF5F6F8);
  static const Color white = Color(0xFFFFFFFF);
  static const Color default_black = Color(0xFF162831);
  static const Color closeDialogColor = Color(0xFF444444);
  static const Color inactive = Color(0xFFeeeeee);
  static const Color hint = Color(0xFFbababa);
  static const Color md_primary = Color(0xFF00AAFF);
  static const Color md_primary_2 = Color(0xFF80D4FF);
  static const Color md_primary_3 = Color(0xFFCEEEFF);
  static const Color md_secondary = Color(0xFF22CDB1);
  static const Color md_gray = Color(0xFFEEEEEE);
  static const Color md_text_white = Color(0xFFF7F9FA);
  static const Color mdAlert = Color(0xFFF50029);
  static Color mdGradientLightFirst = Color(0xFF00AAFF).withOpacity(0.9);
  static Color mdGradientLightSecond = Color(0xFF005FAA).withOpacity(0.8);
  static Color mdGradientFirst = Color(0xFF1AB2FF);
  static Color mdGradientSecond = Color(0xFF34BADF);
  static Color mdGradientThird = Color(0xFF38D2B9);
  static Color mdGreenGradientFirst = Color(0xFF00B303);
  static Color mdGreenGradientSecond = Color(0xFF006602);
  static Color mdDarkGradientFirst = Color(0xFF48596B);
  static Color mdDarkGradientSecond = Color(0xFF3C485);
  static Color mdDarkGradientThird = Color(0xFF1B1F23);
  static Color emptyStar = Color(0xFFC4C4C4);

  static Map<int, Color> colorCodes = {
    50: const Color.fromRGBO(0, 51, 153, .1),
    100: const Color.fromRGBO(0, 51, 153, .2),
    200: const Color.fromRGBO(0, 51, 153, .3),
    300: const Color.fromRGBO(0, 51, 153, .4),
    400: const Color.fromRGBO(0, 51, 153, .5),
    500: const Color.fromRGBO(0, 51, 153, .6),
    600: const Color.fromRGBO(0, 51, 153, .7),
    700: const Color.fromRGBO(0, 51, 153, .8),
    800: const Color.fromRGBO(0, 51, 153, .9),
    900: const Color.fromRGBO(0, 51, 153, 1),
  };// Opacity 20%
}

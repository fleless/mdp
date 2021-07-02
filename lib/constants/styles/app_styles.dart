import 'dart:ui';
import 'package:flutter/material.dart';

import '../app_colors.dart';

/// This class provides custom styles to be used in the project.
///
class AppStyles {
  AppStyles._();

  static const headerWhite = TextStyle(
    fontFamily: 'UniformRounded',
    color: AppColors.white,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  static const bigHeaderWhite = TextStyle(
    fontFamily: 'UniformRounded',
    color: AppColors.white,
    fontWeight: FontWeight.w700,
    fontSize: 34,
  );

  static const headerMdDarkBlue = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_dark_blue,
    fontWeight: FontWeight.w700,
    fontSize: 34,
  );

  static const headerSecondary = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_secondary,
    fontWeight: FontWeight.w700,
    fontSize: 34,
  );

  static const underlinedwhiteText = TextStyle(
    shadows: [Shadow(color: AppColors.white, offset: Offset(0, -5))],
    fontFamily: 'roboto',
    color: Colors.transparent,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.white,
    decorationThickness: 2,
  );

  static const header1 = TextStyle(
    fontFamily: 'UniformRounded',
    color: AppColors.default_black,
    fontWeight: FontWeight.w400,
    fontSize: 19,
  );

  static const header3 = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.default_black,
    fontWeight: FontWeight.w700,
    fontSize: 19,
  );

  static const header1MdDarkBlue = TextStyle(
    fontFamily: 'UniformRounded',
    color: AppColors.md_dark_blue,
    fontWeight: FontWeight.w400,
    fontSize: 19,
  );

  static const header1White = TextStyle(
    fontFamily: 'UniformRounded',
    color: AppColors.white,
    fontWeight: FontWeight.w300,
    fontSize: 18,
  );

  static const header1WhiteBold = TextStyle(
    fontFamily: 'UniformRounded',
    color: AppColors.white,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static const textNormalPlaceholder = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_text_light,
    fontWeight: FontWeight.w400,
    fontSize: 15,
  );

  static const buttonTextWhite = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_text_white,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const buttonTextDarkBlue = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_dark_blue,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const buttonInactiveText = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.placeHolder,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const bodyBold = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.default_black,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
  static const bodyBoldWhite = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.white,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
  static const bodyBoldMdDarkBlue = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_dark_blue,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static const alertNotification = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.mdAlert,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static const largeTextBoldDarkBlue = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_dark_blue,
    fontWeight: FontWeight.w700,
    fontSize: 22,
  );

  static const largeTextNormalDarkBlue = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_dark_blue,
    fontWeight: FontWeight.w400,
    fontSize: 22,
  );

  static const smallTitleWhite = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_text_white,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const navBarTitle = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_text_white,
    fontWeight: FontWeight.w400,
    fontSize: 11,
  );

  static const textNormal = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_dark,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontSize: 14,
  );

  static const inactiveTextNormal = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.inactive,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontSize: 14,
  );

  static const body = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.default_black,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static const smallGray = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_text_light,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static const bodyMdTextLight = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_text_light,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static const bodyPrimaryColor = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_primary,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );



  static const textNormalBold = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.default_black,
    fontWeight: FontWeight.w700,
    fontSize: 15,
  );

  static const bodyWhite = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_text_white,
    fontWeight: FontWeight.w400,
    fontSize: 15,
  );

  static const bodyHint = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.hint,
    fontWeight: FontWeight.w400,
    fontSize: 15,
  );

  static const miniCap = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.default_black,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );

  static const subheadingWhite = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.white,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static const subheadingWhiteBold = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.white,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static const smallBodyWhite = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_text_white,
    fontWeight: FontWeight.w200,
    fontSize: 12,
  );

  static const header2 = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.default_black,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );

  static const header2DarkBlue = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_dark_blue,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );

  static const header2Gray = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.placeHolder,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );

  static const subTitleBlack = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.default_black,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static const subTitleWhite = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_text_white,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static const tinyTitleWhite = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_text_white,
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );

  static const boldText = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.default_black,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const alertNormalText = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.mdAlert,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const textFieldError = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.mdAlert,
    fontWeight: FontWeight.w400,
    fontSize: 11,
  );

  static const secondaryNormalText = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_secondary,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const bigSecondaryText = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_secondary,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static const smallMdDark = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.closeDialogColor,
    fontWeight: FontWeight.w400,
    fontSize: 13,
  );

  static const smallMdDarkBold = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.closeDialogColor,
    fontWeight: FontWeight.w700,
    fontSize: 13,
  );

  static const bodyDefaultBlack = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.default_black,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

}

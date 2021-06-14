import 'dart:ui';
import 'package:flutter/material.dart';

import '../app_colors.dart';

/// This class provides custom styles to be used in the project.
///
class AppStyles {
  AppStyles._();

  static const textNormal = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.default_black,
    fontWeight: FontWeight.w400,
    height: 1.4,
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

  static const bodyPrimaryColor = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_primary,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static const textNormalPlaceholder = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.placeHolder,
    fontWeight: FontWeight.w400,
    fontSize: 14,
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

  static const subheadingBlack = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.default_black,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static const smallBodyWhite = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_text_white,
    fontWeight: FontWeight.w200,
    fontSize: 12,
  );

  static const header1 = TextStyle(
    fontFamily: 'UniformRounded',
    color: AppColors.default_black,
    fontWeight: FontWeight.w400,
    fontSize: 19,
  );

  static const header2 = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.default_black,
    fontWeight: FontWeight.w700,
    fontSize: 19,
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

  static const smallTitleWhite = TextStyle(
    fontFamily: 'roboto',
    color: AppColors.md_text_white,
    fontWeight: FontWeight.w700,
    fontSize: 14,
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

}

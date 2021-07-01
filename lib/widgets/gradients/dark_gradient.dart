import 'package:flutter/cupertino.dart';
import 'package:mdp/constants/app_colors.dart';

LinearGradient DarkGradient() {
  return LinearGradient(
      colors: [
        AppColors.mdDarkGradientFirst,
        AppColors.mdDarkGradientSecond,
      ],
      begin: Alignment(0.0, 0.0),
      end: Alignment(3.0, 5.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);
}

import 'package:flutter/cupertino.dart';
import 'package:mdp/constants/app_colors.dart';

LinearGradient MdGradientGreen() {
  return LinearGradient(
      colors: [
        AppColors.mdGreenGradientFirst,
        AppColors.mdGreenGradientSecond,
      ],
      begin: Alignment(-1.0, -4.0),
      end: Alignment(1.0, 4.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);
}

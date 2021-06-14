import 'package:flutter/cupertino.dart';
import 'package:mdp/constants/app_colors.dart';

LinearGradient MdGradient() {
  return LinearGradient(
      colors: [
        AppColors.mdGradientFirst,
        AppColors.mdGradientSecond,
        AppColors.mdGradientThird,
      ],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 0.0),
      stops: [0.0, 0.25,1.0],
      tileMode: TileMode.clamp);
}

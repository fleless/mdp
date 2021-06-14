import 'package:flutter/cupertino.dart';
import 'package:mdp/constants/app_colors.dart';

LinearGradient MdGradientLight() {
  return LinearGradient(
      colors: [
        AppColors.mdGradientLightFirst,
        AppColors.mdGradientLightSecond,
      ],
      begin: const FractionalOffset(0.0, 0.6),
      end: const FractionalOffset(1.0, 0.8),
      stops: [0.4, 1.0],
      tileMode: TileMode.clamp);
}

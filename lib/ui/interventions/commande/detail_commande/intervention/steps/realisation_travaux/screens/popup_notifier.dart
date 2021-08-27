import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/styles/app_styles.dart';

Widget popUpNotifier(String message, String picto, String buttonText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message,
            style: AppStyles.header3,
            textAlign: TextAlign.center,
            maxLines: 10,
            overflow: TextOverflow.ellipsis),
        SvgPicture.asset(picto),
        ElevatedButton(
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.md_dark_blue),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              child: Text(
                buttonText,
                style: AppStyles.buttonTextDarkBlue,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          onPressed: () {
            Modular.to.pop();
          },
          style: ElevatedButton.styleFrom(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPrimary: AppColors.md_dark_blue.withOpacity(0.1),
              primary: Colors.transparent,
              padding: EdgeInsets.zero,
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}

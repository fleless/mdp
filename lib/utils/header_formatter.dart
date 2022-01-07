import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/utils/shared_preferences.dart';

class HeaderFormatter {
  final sharedPref = Modular.get<SharedPref>();

  Future<Map<String, String>> getHeader() async {
    String token = await sharedPref.read(AppConstants.TOKEN_KEY);
    if (token == null) {
      token = "";
    }
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Referer': Platform.isAndroid ? "android-app" : "ios-app",
      "Authorization": "Bearer " + token,
    };
  }

  tokenExpired() async {
    Fluttertoast.showToast(msg: "la session a expiré");
    await sharedPref.remove(AppConstants.TOKEN_KEY);
    Modular.to
        .pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
  }
}

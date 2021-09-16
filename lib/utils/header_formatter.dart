import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/utils/shared_preferences.dart';

class HeaderFormatter {
  final sharedPref = Modular.get<SharedPref>();

  Future<Map<String, String>> getHeader() async {
    String token = await sharedPref.read(AppConstants.TOKEN_KEY);
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Referer': Platform.isAndroid ? "android-app" : "ios-app",
      "Authorization": "Bearer " + token,
    };
  }
}

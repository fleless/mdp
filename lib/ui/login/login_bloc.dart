import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/network/repository/login_repository.dart';
import 'package:mdp/utils/shared_preferences.dart';

class LoginBloc extends Disposable {
  final controller = StreamController();
  final LoginRepository _loginRepository =
  LoginRepository();
  final SharedPref sharedPref = SharedPref();
  String token = "";

  Future<LoginResponse> getToken(
      String username, String password) async {
    LoginResponse response = await _loginRepository
        .getToken(username, password);
    if((response.token != null)&&(response.token != "")){
      token = response.token;
      sharedPref.save(AppConstants.TOKEN_KEY, token);
    }
    return response;
  }

  dispose() {
    controller.close();
  }

}

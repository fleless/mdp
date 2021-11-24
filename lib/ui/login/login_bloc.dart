import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/models/responses/get_account_response.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/models/responses/profile_response.dart';
import 'package:mdp/network/repository/device_repository.dart';
import 'package:mdp/network/repository/login_repository.dart';
import 'package:mdp/ui/profil/profile_bloc.dart';
import 'package:mdp/utils/shared_preferences.dart';

class LoginBloc extends Disposable {
  final controller = StreamController();
  final LoginRepository _loginRepository = LoginRepository();
  final DeviceRepository _deviceRepository = DeviceRepository();
  final sharedPref = Modular.get<SharedPref>();
  final profileBloc = Modular.get<ProfileBloc>();
  String token = "";

  Future<LoginResponse> getToken(String username, String password) async {
    LoginResponse response =
        await _loginRepository.getToken(username, password);
    if ((response.token != null) && (response.token != "")) {
      token = response.token;
      sharedPref.save(AppConstants.TOKEN_KEY, token);
    }
    return response;
  }

  Future<GetAccountResponse> getAccount(String username) async {
    return _loginRepository.getAccount(username);
  }

  Future<bool> registerDevice(
      String uuid, String deviceToken, num personId, String personData) async {
    ProfileResponse resp = await profileBloc.getProfile(uuid);
    String token = await FirebaseMessaging.instance.getToken();
    return _deviceRepository.registerDevice(
        token,
        resp.subcontractor.user.personId,
        resp.subcontractor.user.firstName +
            " " +
            resp.subcontractor.user.lastName);
  }

  dispose() {
    controller.close();
  }
}

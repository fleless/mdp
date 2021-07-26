import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/models/responses/profile_response.dart';
import 'package:mdp/network/repository/login_repository.dart';

class ProfileBloc extends Disposable {
  final controller = StreamController();
  final LoginRepository _loginRepository = LoginRepository();

  Future<ProfileResponse> getProfile(String uuidUser) async {
    ProfileResponse response = await _loginRepository.getProfile(uuidUser);
    return response;
  }

  dispose() {
    controller.close();
  }
}

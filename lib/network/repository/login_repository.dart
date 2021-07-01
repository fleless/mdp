import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/network/api/login_api_provider.dart';

class LoginRepository {
  LoginApiProvider _apiProvider = new LoginApiProvider();

  Future<LoginResponse> getToken(String username, String password) {
    return _apiProvider.getToken(username, password);
  }
}

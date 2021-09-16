import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/get_account_response.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/models/responses/profile_response.dart';
import 'package:mdp/utils/header_formatter.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class LoginApiProvider {
  final String getTokenEndPoint = Endpoints.AUTH_URL + "token";
  final String getProfilEndPoint =
      Endpoints.AUTH_URL + "subcontractor/profile/";
  final String getAccountEndPoint = Endpoints.AUTH_URL + "users/account";
  final sharedPref = Modular.get<SharedPref>();
  final headerFormatter = Modular.get<HeaderFormatter>();
  Dio _dio;

  LoginApiProvider() {
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 1000, // 5 seconds
          receiveTimeout: 3 * 1000 // 5 seconds
          );

      _dio = new Dio(options);
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: false,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }
  }

  Future<LoginResponse> getToken(String username, String password) async {
    try {
      var params = {
        "username": username,
        "password": password,
        "host": Platform.isAndroid ? "android-app" : "ios-app"
      };
      Response response = await _dio.post(getTokenEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return LoginResponse.fromJson(response.data);
    } on DioError catch (e) {
      return LoginResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<ProfileResponse> getProfile(String uuidUser) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(getProfilEndPoint + uuidUser,
          options: Options(responseType: ResponseType.json, headers: header));
      return ProfileResponse.fromJson(response.data);
    } on DioError catch (e) {
      return ProfileResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<GetAccountResponse> getAccount(String username) async {
    Map<String, String> header = await headerFormatter.getHeader();
    var params = {"username": username};
    try {
      Response response = await _dio.post(getAccountEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return GetAccountResponse.fromJson(response.data);
    } on DioError catch (e) {
      return GetAccountResponse();
    } catch (e) {
      throw e;
    }
  }
}

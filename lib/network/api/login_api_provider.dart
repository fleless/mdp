import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/get_account_response.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/models/responses/profile_response.dart';
import 'package:mdp/utils/header_formatter.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/foundation.dart';

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
          connectTimeout: 15 * 1000, // 15 seconds
          receiveTimeout: 15 * 1000 // 15 seconds
          );

      _dio = new Dio(options);
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: kDebugMode ? true : false,
          requestBody: kDebugMode ? true : false,
          responseBody: kDebugMode ? true : false,
          responseHeader: kDebugMode ? true : false,
          error: kDebugMode ? true : false,
          compact: kDebugMode ? true : false,
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
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
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
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return GetAccountResponse();
    } catch (e) {
      throw e;
    }
  }
}

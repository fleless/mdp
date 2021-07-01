import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class LoginApiProvider {
  final String getTokenEndPoint = Endpoints.AUTH_URL + "token";

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
        "host": "ios-app"
      };
      const Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
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
}

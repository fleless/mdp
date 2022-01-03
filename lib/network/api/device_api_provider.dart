import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/utils/header_formatter.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DeviceApiProvider {
  final String registerDeviceEndPoint =
      "https://api-communication.mesdepanneurs.wtf/api/push/register-device";
  final sharedPref = Modular.get<SharedPref>();
  final headerFormatter = Modular.get<HeaderFormatter>();
  Dio _dio;

  DeviceApiProvider() {
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 15 * 1000, // 15 seconds
          receiveTimeout: 15 * 1000 // 15 seconds
          );

      _dio = new Dio(options);
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: false,
          requestBody: false,
          responseBody: false,
          responseHeader: false,
          error: false,
          compact: false,
          maxWidth: 90));
    }
  }

  Future<bool> registerDevice(
      String deviceToken, num personId, String personData) async {
    Map<String, String> header = await headerFormatter.getHeader();
    var params = {
      "deviceToken": deviceToken,
      "platformArn": null,
      "userData": personData,
      "personId": personId,
      "topicArn": null
    };
    try {
      Response response = await _dio.post(registerDeviceEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      if (response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

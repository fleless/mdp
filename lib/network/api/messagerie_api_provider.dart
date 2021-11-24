import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/add_message_response.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/models/responses/messagerie_response.dart';
import 'package:mdp/utils/header_formatter.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MessagerieApiProvider {
  final sharedPref = Modular.get<SharedPref>();
  final String getMessagesEndPoint = Endpoints.CORE_URL + "order/";
  final headerFormatter = Modular.get<HeaderFormatter>();

  Dio _dio;

  MessagerieApiProvider() {
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

  Future<MessageResponse> getMessages(String idCommande) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(
          getMessagesEndPoint + idCommande + "/messages",
          options: Options(responseType: ResponseType.json, headers: header));
      return MessageResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return MessageResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<AddMessageResponse> sendMessage(String idCommande, String body) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      var params = {"type_id": 1, "subject": "mobinaute", "body": body};
      Response response = await _dio.post(
          getMessagesEndPoint + idCommande + "/messages",
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return AddMessageResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return AddMessageResponse();
    } catch (e) {
      throw e;
    }
  }
}

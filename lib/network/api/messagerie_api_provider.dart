import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/add_message_response.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/models/responses/messagerie_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MessagerieApiProvider {
  final String getMessagesEndPoint = Endpoints.CORE_URL + "order/";

  Dio _dio;

  MessagerieApiProvider() {
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

  Future<MessageResponse> getMessages(String idCommande) async {
    try {
      Response response =
          await _dio.get(getMessagesEndPoint + idCommande + "/messages",
              options: Options(responseType: ResponseType.json, headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
              }));
      return MessageResponse.fromJson(response.data);
    } on DioError catch (e) {
      return MessageResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<AddMessageResponse> sendMessage(String idCommande, String body) async {
    try {
      var params = {"type_id": 1, "subject": "mobinaute", "body": body};
      Response response =
          await _dio.post(getMessagesEndPoint + idCommande + "/messages",
              options: Options(responseType: ResponseType.json, headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
              }),
              data: jsonEncode(params));
      return AddMessageResponse.fromJson(response.data);
    } on DioError catch (e) {
      return AddMessageResponse();
    } catch (e) {
      throw e;
    }
  }
}
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/requests/delete_notifications_request.dart';
import 'package:mdp/models/responses/delete_notifications_response.dart';
import 'package:mdp/models/responses/get_notifications_Response.dart';
import 'package:mdp/utils/header_formatter.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NotificationsApiProvider {
  final headerFormatter = Modular.get<HeaderFormatter>();
  final String getNotificationsEndPoint =
      Endpoints.CORE_URL + "notifications/subcontractor/";
  final String deleteNotificationsEndPoint =
      Endpoints.CORE_URL + "notification/delete";
  final sharedPref = Modular.get<SharedPref>();
  Dio _dio;

  NotificationsApiProvider() {
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 15 * 1000, // 15 seconds
          receiveTimeout: 15 * 1000 // 15 seconds
          );

      _dio = new Dio(options);
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90));
    }
  }

  Future<GetNotificationsResponse> getNotifications() async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      String _subcontractorUuid =
          await sharedPref.read(AppConstants.SUBCONTRACTOR_UUID_KEY);
      Response response = await _dio.get(
          getNotificationsEndPoint + _subcontractorUuid,
          options: Options(responseType: ResponseType.json, headers: header));
      return GetNotificationsResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return GetNotificationsResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<DeleteNotificationsResponse> deleteNotifications(
      List<DeleteNotificationsRequest> ids) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.put(deleteNotificationsEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(ids));
      return DeleteNotificationsResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return DeleteNotificationsResponse();
    } catch (e) {
      throw e;
    }
  }
}

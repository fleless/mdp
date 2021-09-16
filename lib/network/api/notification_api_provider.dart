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
      "https://order.mesdepanneurs.wtf/api/v1/notifications/subcontractor/";
  final String deleteNotificationsEndPoint =
      "https://order.mesdepanneurs.wtf/api/v1/notification/delete";
  final sharedPref = Modular.get<SharedPref>();
  Dio _dio;

  NotificationsApiProvider() {
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
      return DeleteNotificationsResponse();
    } catch (e) {
      throw e;
    }
  }
}

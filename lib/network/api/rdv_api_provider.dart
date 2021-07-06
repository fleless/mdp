import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RdvApiProvider {
  final String getUserAppointmentsURL =
      Endpoints.CORE_URL + "visits";

  Dio _dio;

  RdvApiProvider() {
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 1000, // 5 seconds
          receiveTimeout: 3 * 1000 // 5 seconds
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

  Future<UserAppointmentsResponse> getUserAppointments(
      String idUser) async {
    try {
      Response response =
      await _dio.get(getUserAppointmentsURL + "/"+idUser+"/2021-01-01/2100-12-31",
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }));
      return UserAppointmentsResponse.fromJson(response.data);
    } on DioError catch (e) {
      return UserAppointmentsResponse();
    } catch (e) {
      throw e;
    }
  }

}

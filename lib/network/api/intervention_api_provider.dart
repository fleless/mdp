import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class InterventionApiProvider {
  final String showInterventionEndPoint =
      Endpoints.CORE_URL + "show-intervention/";

  Dio _dio;

  InterventionApiProvider() {
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

  Future<ShowInterventionResponse> showIntervention(
      String idIntervention) async {
    try {
      Response response =
          await _dio.get(showInterventionEndPoint + idIntervention,
              options: Options(responseType: ResponseType.json, headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
              }));
      return ShowInterventionResponse.fromJson(response.data);
    } on DioError catch (e) {
      return ShowInterventionResponse();
    } catch (e) {
      throw e;
    }
  }
}

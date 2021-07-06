import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/intervention_detail_response.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class InterventionApiProvider {
  final String showInterventionEndPoint =
      Endpoints.CORE_URL + "show-intervention/";
  final String refuseEndPoint = Endpoints.URL + "competition/refuse";
  final String acceptEndPoint = Endpoints.URL + "competition/accept";
  final String getInterventionDetailEndPoint =
      Endpoints.CORE_URL + "order-detail/";
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
          requestBody: true,
          responseBody: true,
          responseHeader: true,
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

  Future<InterventionDetailResponse> getInterventionDetail(
      String idIntervention) async {
    try {
      Response response =
      await _dio.get(getInterventionDetailEndPoint + idIntervention,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }));
      return InterventionDetailResponse.fromJson(response.data);
    } on DioError catch (e) {
      return InterventionDetailResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<int> refuseCompetition(String reference, String commentaire,
      int idIntervention, String uuidIntervention, String idUser) async {
    try {
      var params = {
        "order": reference,
        "string": commentaire,
        "user": idUser,
        "id": idIntervention,
        "uuid": uuidIntervention
      };
      Response response = await _dio.put(refuseEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return response.statusCode;
    } on DioError catch (e) {
      return 500;
    } catch (e) {
      throw e;
    }
  }

  Future<int> acceptIntervention(String reference, int idIntervention,
      String uuidIntervention, String idUser) async {
    try {
      var params = {
        "order": reference,
        "user": idUser,
        "id": idIntervention,
        "uuid": uuidIntervention
      };
      Response response = await _dio.put(acceptEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return response.statusCode;
    } on DioError catch (e) {
      return 500;
    } catch (e) {
      throw e;
    }
  }
}

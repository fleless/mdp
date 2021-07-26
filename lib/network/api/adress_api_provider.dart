import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/adressResponse.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/models/responses/profile_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AdressApiProvider {
  final String getCommunityNameFromZIPEndPoint1 =
      "https://geo.api.gouv.fr/communes?codePostal=";
  final String getCommunityNameFromZIPEndPoint2 =
      "&fields=nom&format=json&geometry=centre";

  Dio _dio;

  AdressApiProvider() {
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

  Future<List<AdressResponse>> getCommunityNameFromZipCode(String zip) async {
    try {
      Response response = await _dio.get(
          getCommunityNameFromZIPEndPoint1 +
              zip +
              getCommunityNameFromZIPEndPoint2,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }));
      var res = response.data as List;
      return res.map((x) => AdressResponse.fromJson(x)).toList();
    } on DioError catch (e) {
      List<AdressResponse> vide = <AdressResponse>[];
      return vide;
    } catch (e) {
      throw e;
    }
  }
}

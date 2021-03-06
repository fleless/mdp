import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/models/responses/adressResponse.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AdressApiProvider {
  final String getCommunityNameFromZIPEndPoint1 =
      "https://geo.api.gouv.fr/communes?codePostal=";
  final String getCommunityNameFromZIPEndPoint2 =
      "&fields=nom&format=json&geometry=centre";
  final sharedPref = Modular.get<SharedPref>();

  Dio _dio;

  AdressApiProvider() {
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

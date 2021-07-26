import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/get_designations_name.dart';
import 'package:mdp/models/responses/get_materials_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RedactionDevisApiProvider {
  final String getDesignationsNameURL = Endpoints.CORE_URL + "quote/reference";
  final String getMaterialsEndPoint =
      Endpoints.CORE_URL + "workload?types[]=MATERIAL";

  Dio _dio;

  RedactionDevisApiProvider() {
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

  Future<GetDesignationsNameResponse> getDesignationsName() async {
    try {
      Response response = await _dio.get(getDesignationsNameURL,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }));
      return GetDesignationsNameResponse.fromJson(response.data);
    } on DioError catch (e) {
      return GetDesignationsNameResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<GetMaterialResponse> getMaterials() async {
    try {
      Response response = await _dio.get(getMaterialsEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }));
      return GetMaterialResponse.fromJson(response.data);
    } on DioError catch (e) {
      return GetMaterialResponse();
    } catch (e) {
      throw e;
    }
  }
}

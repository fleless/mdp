import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/add_new_material_response.dart';
import 'package:mdp/models/responses/get_designations_name.dart';
import 'package:mdp/models/responses/get_materials_response.dart';
import 'package:mdp/models/responses/units_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RedactionDevisApiProvider {
  final String getDesignationsNameURL = Endpoints.CORE_URL + "quote/reference";
  final String addNewMaterialEndPoint = Endpoints.CORE_URL + "workload";
  final String getMaterialsEndPoint =
      Endpoints.CORE_URL + "workload?types[]=MATERIAL";
  final String getUnitsEndPoint = Endpoints.CORE_URL + "workload/units";
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

  Future<AddNewMaterialResponse> addNewMaterial(String name, String comment,
      int unit, int quantity, double unit_price) async {
    var params = {
      "name": name,
      "type": 2,
      "unit": unit,
      "quantity": quantity,
      "unit_price": unit_price,
      "comment": comment
    };
    try {
      Response response = await _dio.post(addNewMaterialEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return AddNewMaterialResponse.fromJson(response.data);
    } on DioError catch (e) {
      return AddNewMaterialResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<GetUnitsResponse> getUnits() async {
    try {
      Response response = await _dio.get(getUnitsEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }));
      return GetUnitsResponse.fromJson(response.data);
    } on DioError catch (e) {
      return GetUnitsResponse();
    } catch (e) {
      throw e;
    }
  }
}

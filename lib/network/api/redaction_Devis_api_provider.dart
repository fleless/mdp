import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/requests/ajout_designation_request.dart';
import 'package:mdp/models/responses/add_designation_response.dart';
import 'package:mdp/models/responses/add_new_material_response.dart';
import 'package:mdp/models/responses/get_designations_name.dart';
import 'package:mdp/models/responses/get_devis_response.dart';
import 'package:mdp/models/responses/get_materials_response.dart';
import 'package:mdp/models/responses/get_notif_refus_response.dart';
import 'package:mdp/models/responses/send_mail_devis_response.dart';
import 'package:mdp/models/responses/units_response.dart';
import 'package:mdp/models/responses/updateQuoteResponse.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RedactionDevisApiProvider {
  final String getDesignationsNameURL = Endpoints.CORE_URL + "quote/reference";
  final String addNewMaterialEndPoint = Endpoints.CORE_URL + "workload";
  final String getMaterialsEndPoint =
      Endpoints.CORE_URL + "workload?types[]=MATERIAL";
  final String getMainDeplacementsEndPoint =
      Endpoints.CORE_URL + "workload?types[]=MANPOWER&types[]=TRAVEL_TIME";
  final String getUnitsEndPoint = Endpoints.CORE_URL + "workload/units";
  final String addDesignationEndPoint = Endpoints.CORE_URL + "quote/details";
  final String getDevisEndPoint = Endpoints.CORE_URL + "quotes/";
  final String updateDesignationEndPoint =
      Endpoints.CORE_URL + "quote/details/edit";
  final String updateQuoteEndPoint = Endpoints.CORE_URL + "quote/edit";
  final String sendDevisMailEndPoint = Endpoints.CORE_URL + "quote/send/email";
  final String notifierRefusEndPoint = Endpoints.CORE_URL + "quote/";

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

  Future<GetMaterialResponse> getMainDeplacement() async {
    try {
      Response response = await _dio.get(getMainDeplacementsEndPoint,
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

  Future<AddDesignationResponse> addDesignation(
      AddDesignationRequest request) async {
    try {
      Response response = await _dio.post(addDesignationEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(request));
      return AddDesignationResponse.fromJson(response.data);
    } on DioError catch (e) {
      return AddDesignationResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<GetDevisResponse> getDevis(String orderId) async {
    try {
      Response response = await _dio.get(getDevisEndPoint + orderId,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }));
      return GetDevisResponse.fromJson(response.data);
    } on DioError catch (e) {
      return GetDevisResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<AddDesignationResponse> updateDesignation(
      AddDesignationRequest request) async {
    try {
      Response response = await _dio.put(updateDesignationEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(request));
      return AddDesignationResponse.fromJson(response.data);
    } on DioError catch (e) {
      return AddDesignationResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<UpdateQuoteResponse> updateQuote(
      num quoteId, num tva, num remise, num franchise, num accompte) async {
    var params = {
      "quote": quoteId,
      "vat": tva,
      "discount": remise,
      "franchise": franchise,
      "advance": accompte,
      "advance_payment_sum": accompte,
    };
    try {
      Response response = await _dio.put(updateQuoteEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return UpdateQuoteResponse.fromJson(response.data);
    } on DioError catch (e) {
      return UpdateQuoteResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<SendMailDevisResponse> sendMailDevis(num quoteId, String email) async {
    var params = {"quote_id": quoteId, "email": email};
    try {
      Response response = await _dio.post(sendDevisMailEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return SendMailDevisResponse.fromJson(response.data);
    } on DioError catch (e) {
      return SendMailDevisResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<GetNotifRefusResponse> notifierRefus(num quoteId) async {
    var params = {
      "type_id": 1,
      "subject": "Notifier Refus Devis",
      "body": "Le client a refusé la signature du devis "
    };
    try {
      Response response = await _dio.post(
          notifierRefusEndPoint + quoteId.toString() + "/messages",
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return GetNotifRefusResponse.fromJson(response.data);
    } on DioError catch (e) {
      return GetNotifRefusResponse();
    } catch (e) {
      throw e;
    }
  }
}

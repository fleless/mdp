import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
import 'package:mdp/models/signing_conditions_model.dart';
import 'package:mdp/utils/header_formatter.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RedactionDevisApiProvider {
  final sharedPref = Modular.get<SharedPref>();
  final headerFormatter = Modular.get<HeaderFormatter>();
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
          connectTimeout: 15 * 1000, // 15 seconds
          receiveTimeout: 15 * 1000 // 15 seconds
          );

      _dio = new Dio(options);
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: kDebugMode ? true : false,
          requestBody: kDebugMode ? true : false,
          responseBody: kDebugMode ? true : false,
          responseHeader: kDebugMode ? true : false,
          error: kDebugMode ? true : false,
          compact: kDebugMode ? true : false,
          maxWidth: 90));
    }
  }

  Future<GetDesignationsNameResponse> getDesignationsName() async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(getDesignationsNameURL,
          options: Options(responseType: ResponseType.json, headers: header));
      return GetDesignationsNameResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return GetDesignationsNameResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<GetMaterialResponse> getMaterials() async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(getMaterialsEndPoint,
          options: Options(responseType: ResponseType.json, headers: header));
      return GetMaterialResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return GetMaterialResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<AddNewMaterialResponse> addNewMaterial(String name, String comment,
      int unit, int quantity, double unit_price) async {
    Map<String, String> header = await headerFormatter.getHeader();
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
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return AddNewMaterialResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return AddNewMaterialResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<GetUnitsResponse> getUnits() async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(getUnitsEndPoint,
          options: Options(responseType: ResponseType.json, headers: header));
      return GetUnitsResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return GetUnitsResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<GetMaterialResponse> getMainDeplacement() async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(getMainDeplacementsEndPoint,
          options: Options(responseType: ResponseType.json, headers: header));
      return GetMaterialResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return GetMaterialResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<AddDesignationResponse> addDesignation(
      AddDesignationRequest request) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.post(addDesignationEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(request));
      return AddDesignationResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return AddDesignationResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<GetDevisResponse> getDevis(String orderId) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(getDevisEndPoint + orderId,
          options: Options(responseType: ResponseType.json, headers: header));
      return GetDevisResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return GetDevisResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<AddDesignationResponse> updateDesignation(
      AddDesignationRequest request) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.put(updateDesignationEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(request));
      return AddDesignationResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return AddDesignationResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<UpdateQuoteResponse> updateQuote(
      num quoteId, num tva, num remise, num franchise, num accompte) async {
    Map<String, String> header = await headerFormatter.getHeader();
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
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return UpdateQuoteResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return UpdateQuoteResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<bool> sendMailDevis(num quoteId, String email) async {
    Map<String, String> header = await headerFormatter.getHeader();
    var params = {"quote_id": quoteId, "email": email};
    try {
      Response response = await _dio.post(sendDevisMailEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return response.statusCode == 200 ? true : false;
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<GetNotifRefusResponse> notifierRefus(num quoteId) async {
    Map<String, String> header = await headerFormatter.getHeader();
    var params = {
      "type_id": 1,
      "subject": "Notifier Refus Devis",
      "body": "Le client a refusé la signature du devis "
    };
    try {
      Response response = await _dio.post(
          notifierRefusEndPoint + quoteId.toString() + "/messages",
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return GetNotifRefusResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return GetNotifRefusResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<UpdateQuoteResponse> updateSignatureConditionsQuote(
      num quoteId, List<SigningConditionsModel> signingConditions) async {
    Map<String, String> header = await headerFormatter.getHeader();
    var params = {
      "quote": quoteId,
      "signing_conditions": signingConditions.map((e) => e.toJson()).toList(),
    };
    try {
      Response response = await _dio.put(updateQuoteEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return UpdateQuoteResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return UpdateQuoteResponse();
    } catch (e) {
      throw e;
    }
  }
}

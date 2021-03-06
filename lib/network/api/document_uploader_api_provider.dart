import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/requests/generation_pv_request.dart';
import 'package:mdp/models/responses/add_type_document_response.dart';
import 'package:mdp/models/responses/upload_document_response.dart';
import 'package:mdp/utils/header_formatter.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DocumentUploaderApiProvider {
  final String uploadQuoteDocumentEndPoint =
      Endpoints.CORE_URL + "upload-quote-document";
  final String uploadInterventionDocumentEndPoint =
      Endpoints.CORE_URL + "upload-order-document";
  final String ajoutTypeDocumentEndPoint =
      Endpoints.CORE_URL + "add-order-document-type";
  final String generateeDocumentEndPoint =
      "https://api-order.mesdepanneurs.wtf/api/v1/order/generate-document";
  final String uploadPaymentDocumentEndPoint =
      "https://api-order.mesdepanneurs.wtf/api/v1/upload-payment-document";
  final sharedPref = Modular.get<SharedPref>();
  final headerFormatter = Modular.get<HeaderFormatter>();

  Dio _dio;

  DocumentUploaderApiProvider() {
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 15 * 1000, // 15 seconds
          receiveTimeout: 15 * 1000 // 15 seconds
          );

      _dio = new Dio(options);
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: kDebugMode ? true : false,
          requestBody: kDebugMode ? false : false,
          responseBody: kDebugMode ? true : false,
          responseHeader: kDebugMode ? true : false,
          error: kDebugMode ? true : false,
          compact: kDebugMode ? true : false,
          maxWidth: 90));
    }
  }

  Future<UploadDocumentResponse> uploadQuoteDocument(
      String quoteId, int documentTypeId, String documentContent) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      var params = {
        "quoteId": quoteId == null ? null : int.parse(quoteId),
        "quoteReferenceId": null,
        //1:Signature Client, 2:Signature artisan, 3:Photo d??signation
        "documentTypeId": documentTypeId,
        "documentContent": documentContent
      };
      Response response = await _dio.post(uploadQuoteDocumentEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return UploadDocumentResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return UploadDocumentResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<UploadDocumentResponse> uploadInterventionDocument(
      num orderId, int documentTypeId, String documentContent) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      var params = {
        "orderId": orderId,
        "documentTypeId": documentTypeId,
        "documentContent": documentContent
      };
      Response response = await _dio.post(uploadInterventionDocumentEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return UploadDocumentResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return UploadDocumentResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<AddTypeDocumentResponse> addTypeDocument(String name) async {
    try {
      Map<String, String> header = await headerFormatter.getHeader();
      var params = {"name": name};
      Response response = await _dio.post(ajoutTypeDocumentEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return AddTypeDocumentResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return AddTypeDocumentResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<bool> generatePVDocument(
      num orderIdentifier, GenerationPVFinTravauxRequest request) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.post(generateeDocumentEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(request));
      return true;
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return false;
    } catch (e) {
      throw e;
    }
  }

  Future<UploadDocumentResponse> uploadPaymentDocument(
      num paymentId, num documentTypeId, String documentString) async {
    var params = {
      "paymentId": paymentId,
      "documentTypeId": documentTypeId,
      "documentContent": "string"
    };
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.post(uploadPaymentDocumentEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return UploadDocumentResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return UploadDocumentResponse();
    } catch (e) {
      throw e;
    }
  }
}

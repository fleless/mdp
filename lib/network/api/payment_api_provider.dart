import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/finish_payment_response.dart';
import 'package:mdp/models/responses/payment/send_sms_payment_response.dart';
import 'package:mdp/models/responses/payment/start_payment_response.dart';
import 'package:mdp/utils/header_formatter.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class PaymentApiProvider {
  Dio _dio;
  final sharedPref = Modular.get<SharedPref>();
  final headerFormatter = Modular.get<HeaderFormatter>();
  final String startPaymentEndPoint = Endpoints.PAYMENT_URL + "start-payment";
  final String sendSmsPaymentEndPoint =
      "https://api-communication.mesdepanneurs.wtf/api/payment/sms/payment-link";
  final String sendEmailPaymentEndPoint =
      "https://api-communication.mesdepanneurs.wtf/api/payment/email/payment-link";
  final String finishPaymentEndPoint = Endpoints.PAYMENT_URL + "finish-payment";

  PaymentApiProvider() {
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 15 * 1000, // 15 seconds
          receiveTimeout: 15 * 1000 // 15 seconds
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

  Future<StartPaymentResponse> startPayment(String orderCode) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      var params = {"orderCode": orderCode};
      Response response = await _dio.post(startPaymentEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return StartPaymentResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return StartPaymentResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<SendSmsPaymentResponse> sendSmsPayment(
      String phone, String orderCode, String user) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      var params = {
        "address": phone,
        "orderCode": orderCode,
        "shortLink": true,
        "user": user
      };
      Response response = await _dio.post(sendSmsPaymentEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return SendSmsPaymentResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return SendSmsPaymentResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<SendSmsPaymentResponse> sendEmailPayment(
      String email, String orderCode, String user) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      var params = {
        "address": email,
        "orderCode": orderCode,
        "shortLink": true,
        "user": user
      };
      Response response = await _dio.post(sendEmailPaymentEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return SendSmsPaymentResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return SendSmsPaymentResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<FinishPaymentResponse> finishPayment(
      String orderCode, num paymentType) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      var params = {"orderCode": orderCode, "paymentType": paymentType};
      Response response = await _dio.post(finishPaymentEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return FinishPaymentResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return FinishPaymentResponse();
    } catch (e) {
      throw e;
    }
  }
}

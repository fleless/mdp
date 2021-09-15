import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/payment/send_sms_payment_response.dart';
import 'package:mdp/models/responses/payment/start_payment_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class PaymentApiProvider {
  Dio _dio;
  final String startPaymentEndPoint = Endpoints.PAYMENT_URL + "start-payment";
  final String sendSmsPaymentEndPoint =
      "https://api-communication.mesdepanneurs.wtf/api/payment/sms/payment-link";
  final String sendEmailPaymentEndPoint =
      "https://communication.mesdepanneurs.wtf/api/payment/email/payment-link";

  PaymentApiProvider() {
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 10 * 1000, // 5 seconds
          receiveTimeout: 10 * 1000 // 5 seconds
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

  Future<StartPaymentResponse> startPayment(String orderCode) async {
    try {
      var params = {"orderCode": orderCode};
      Response response = await _dio.post(startPaymentEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return StartPaymentResponse.fromJson(response.data);
    } on DioError catch (e) {
      return StartPaymentResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<SendSmsPaymentResponse> sendSmsPayment(
      String phone, String orderCode, String user) async {
    try {
      var params = {
        "address": phone,
        "orderCode": orderCode,
        "shortLink": true,
        "user": user
      };
      Response response = await _dio.post(sendSmsPaymentEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return SendSmsPaymentResponse.fromJson(response.data);
    } on DioError catch (e) {
      return SendSmsPaymentResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<SendSmsPaymentResponse> sendEmailPayment(
      String email, String orderCode, String user) async {
    try {
      var params = {
        "address": email,
        "orderCode": orderCode,
        "shortLink": true,
        "user": user
      };
      Response response = await _dio.post(sendEmailPaymentEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return SendSmsPaymentResponse.fromJson(response.data);
    } on DioError catch (e) {
      return SendSmsPaymentResponse();
    } catch (e) {
      throw e;
    }
  }
}

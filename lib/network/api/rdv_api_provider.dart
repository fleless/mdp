import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/add_appointment_response.dart';
import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:mdp/utils/header_formatter.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RdvApiProvider {
  final sharedPref = Modular.get<SharedPref>();
  final headerFormatter = Modular.get<HeaderFormatter>();
  final String getUserAppointmentsURL = Endpoints.CORE_URL + "visits";
  final String addAppointmentEndPoint = Endpoints.CORE_URL + "visits";
  final String updateAppointmentEndPoint = Endpoints.CORE_URL + "visits/";

  Dio _dio;

  RdvApiProvider() {
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

  Future<UserAppointmentsResponse> getUserAppointments(String idUser) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(
          getUserAppointmentsURL +
              "?start_date=2021-01-01&end_date=2050-08-31&subcontractor_id=" +
              idUser,
          options: Options(responseType: ResponseType.json, headers: header));
      return UserAppointmentsResponse.fromJson(response.data);
    } on DioError catch (e) {
      return UserAppointmentsResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<UserAppointmentsResponse> getUserAppointmentsForSpecificOrder(
      String idUser, String orderId) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(
          getUserAppointmentsURL +
              "?order_id=" +
              orderId +
              "&start_date=2021-01-01&end_date=2050-08-31&subcontractor_id=" +
              idUser,
          options: Options(responseType: ResponseType.json, headers: header));
      return UserAppointmentsResponse.fromJson(response.data);
    } on DioError catch (e) {
      return UserAppointmentsResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<AddAppointmentResponse> addFirstAppointment(
      String title,
      String comment,
      int orderId,
      String subContractorId,
      String startDate,
      String endDate) async {
    Map<String, String> header = await headerFormatter.getHeader();
    var params = {
      "title": title,
      "comment": comment,
      "type_id": "1",
      "order_id": orderId,
      "subcontractor_id": subContractorId,
      "start_date": startDate,
      "end_date": endDate
    };
    try {
      Response response = await _dio.post(addAppointmentEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return AddAppointmentResponse.fromJson(response.data);
    } on DioError catch (e) {
      return AddAppointmentResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<AddAppointmentResponse> addRealisationAppointment(
      String title,
      String comment,
      int orderId,
      String subContractorId,
      String startDate,
      String endDate) async {
    Map<String, String> header = await headerFormatter.getHeader();
    var params = {
      "title": title,
      "comment": comment,
      "type_id": "2",
      "order_id": orderId,
      "subcontractor_id": subContractorId,
      "start_date": startDate,
      "end_date": endDate
    };
    try {
      Response response = await _dio.post(addAppointmentEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return AddAppointmentResponse.fromJson(response.data);
    } on DioError catch (e) {
      return AddAppointmentResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<AddAppointmentResponse> updateFirstAppointment(String title,
      String comment, String startDate, String endDate, String idRdv) async {
    Map<String, String> header = await headerFormatter.getHeader();
    var params = {
      "title": title,
      "comment": comment,
      "start_date": startDate,
      "end_date": endDate
    };
    try {
      Response response = await _dio.put(updateAppointmentEndPoint + idRdv,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return AddAppointmentResponse.fromJson(response.data);
    } on DioError catch (e) {
      return AddAppointmentResponse();
    } catch (e) {
      throw e;
    }
  }
}

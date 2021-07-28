import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/add_adresse_facturation_response.dart';
import 'package:mdp/models/responses/get_interventions.dart';
import 'package:mdp/models/responses/intervention_detail_response.dart';
import 'package:mdp/models/responses/result_message_response.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class InterventionApiProvider {
  final String getInterventionsEndPoint = Endpoints.URL + "list-intervention";
  final String showInterventionEndPoint =
      Endpoints.CORE_URL + "show-intervention/";
  final String refuseEndPoint = Endpoints.URL + "competition/refuse";
  final String acceptEndPoint = Endpoints.URL + "competition/accept";
  final String getInterventionDetailEndPoint =
      Endpoints.CORE_URL + "order-detail/";
  final String modifierCoordClientEndPoint = Endpoints.URL_PERSON + "/client/";
  final String ajouterAdresseFacturationEndPoint =
      Endpoints.URL_PERSON + "/address/create-invoicing-address";
  final String modifierAdresseFacturationEndPoint =
      Endpoints.URL_PERSON + "/address/";

  Dio _dio;

  InterventionApiProvider() {
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 5 * 1000, // 5 seconds
          receiveTimeout: 5 * 1000 // 5 seconds
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

  Future<GetInterventionsResponse> getInterventions(
      String subcontractorId, String code) async {
    var params = {
      "subcontractorId": subcontractorId,
      "sortField": "created",
      "sortOrder": "DESC",
      "filters": {"code": code}
    };
    try {
      Response response = await _dio.post(getInterventionsEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return GetInterventionsResponse.fromJson(response.data);
    } on DioError catch (e) {
      return GetInterventionsResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<ShowInterventionResponse> showIntervention(
      String idIntervention) async {
    try {
      Response response =
          await _dio.get(showInterventionEndPoint + idIntervention,
              options: Options(responseType: ResponseType.json, headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
              }));
      return ShowInterventionResponse.fromJson(response.data);
    } on DioError catch (e) {
      return ShowInterventionResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<InterventionDetailResponse> getInterventionDetail(
      String idIntervention) async {
    try {
      Response response =
          await _dio.get(getInterventionDetailEndPoint + idIntervention,
              options: Options(responseType: ResponseType.json, headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
              }));
      return InterventionDetailResponse.fromJson(response.data);
    } on DioError catch (e) {
      return InterventionDetailResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<int> refuseCompetition(String reference, String commentaire,
      int idIntervention, String uuidIntervention, String idUser) async {
    try {
      var params = {
        "order": reference,
        "string": commentaire,
        "user": idUser,
        "id": idIntervention,
        "uuid": uuidIntervention
      };
      Response response = await _dio.put(refuseEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return response.statusCode;
    } on DioError catch (e) {
      return 500;
    } catch (e) {
      throw e;
    }
  }

  Future<int> acceptIntervention(String reference, int idIntervention,
      String uuidIntervention, String idUser) async {
    try {
      var params = {
        "order": reference,
        "user": idUser,
        "id": idIntervention,
        "uuid": uuidIntervention
      };
      Response response = await _dio.put(acceptEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return response.statusCode;
    } on DioError catch (e) {
      return 500;
    } catch (e) {
      throw e;
    }
  }

  Future<ResultMessageResponse> modifCoordClient(
      String civility,
      String firstname,
      String lastname,
      String phonenumber,
      String mail,
      String uuidClient) async {
    try {
      var params = {
        "civility": civility,
        "firstname": firstname,
        "lastname": lastname,
        "phononumber": phonenumber,
        "mail": mail
      };
      Response response = await _dio.put(
          modifierCoordClientEndPoint + uuidClient + "/update-info",
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return ResultMessageResponse.fromJson(response.data);
    } on DioError catch (e) {
      return ResultMessageResponse(result: "KO", message: "erreur");
    } catch (e) {
      throw e;
    }
  }

  Future<AddAdressFacturationResponse> addAddressFacturation(
      String order,
      String adressFirstname,
      String adressLastName,
      String streetNumber,
      String streetName,
      String additionalAddress,
      String city,
      String postcode) async {
    try {
      var params = {
        "order": order,
        "addressFirstname": adressFirstname,
        "addressLastname": adressLastName,
        "streetNumber": streetNumber,
        "streetName": streetName,
        "additionalAddress": additionalAddress,
        "city": city,
        "postcode": postcode
      };
      Response response = await _dio.post(ajouterAdresseFacturationEndPoint,
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return AddAdressFacturationResponse.fromJson(response.data);
    } on DioError catch (e) {
      return AddAdressFacturationResponse(result: "KO", message: "erreur");
    } catch (e) {
      throw e;
    }
  }

  Future<AddAdressFacturationResponse> modifierAddressFacturation(
      String order,
      String adressFirstname,
      String adressLastName,
      String streetNumber,
      String streetName,
      String additionalAddress,
      String city,
      String postcode) async {
    try {
      var params = {
        "addressFirstname": adressFirstname,
        "addressLastname": adressLastName,
        "streetNumber": streetNumber,
        "streetName": streetName,
        "additionalAddress": additionalAddress,
        "city": city,
        "postcode": postcode
      };
      Response response = await _dio.put(
          modifierAdresseFacturationEndPoint +
              order +
              "/update-invoicing-address",
          options: Options(responseType: ResponseType.json, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }),
          data: jsonEncode(params));
      return AddAdressFacturationResponse.fromJson(response.data);
    } on DioError catch (e) {
      return AddAdressFacturationResponse(result: "KO", message: "erreur");
    } catch (e) {
      throw e;
    }
  }
}

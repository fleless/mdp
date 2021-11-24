import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/models/responses/add_adresse_facturation_response.dart';
import 'package:mdp/models/responses/change_order_state.dart';
import 'package:mdp/models/responses/creation_nouvelle_commande_response.dart';
import 'package:mdp/models/responses/get_interventions.dart';
import 'package:mdp/models/responses/get_types_commandes_response.dart';
import 'package:mdp/models/responses/get_types_documents_response.dart';
import 'package:mdp/models/responses/intervention_detail_response.dart';
import 'package:mdp/models/responses/result_message_response.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:mdp/utils/flushbar_utils.dart';
import 'package:mdp/utils/header_formatter.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class InterventionApiProvider {
  final sharedPref = Modular.get<SharedPref>();
  final headerFormatter = Modular.get<HeaderFormatter>();
  final String getInterventionsEndPoint =
      Endpoints.URL + "v1/list-intervention";
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
  final String changeOrderStateEndPoint =
      Endpoints.CORE_URL + "order-state-change/";
  final String getListeTyesDocumentsEndPoint = Endpoints.CORE_URL +
      "list-order-document?sortField=id&sortOrder=DESC&filters=%7B%22enabled%22:1%7D";
  final String getListeTypesCommandesEndPoint =
      Endpoints.CORE_URL + "order-case/list-order-case";
  final String creationNouvelleCommandeEndPoint =
      Endpoints.CORE_URL + "order/create-additional-order";

  Dio _dio;

  InterventionApiProvider() {
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

  Future<GetInterventionsResponse> getInterventions(
      String subcontractorId, String code) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(
          getInterventionsEndPoint +
              "?subcontractorId=" +
              subcontractorId +
              '&sortField=created&sortOrder=DESC&filters={"code":"' +
              code +
              '"}',
          options: Options(responseType: ResponseType.json, headers: header));
      return GetInterventionsResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return GetInterventionsResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<ShowInterventionResponse> showIntervention(
      String idIntervention) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(
          showInterventionEndPoint + idIntervention,
          options: Options(responseType: ResponseType.json, headers: header));
      return ShowInterventionResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return ShowInterventionResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<InterventionDetailResponse> getInterventionDetail(
      String idIntervention) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(
          getInterventionDetailEndPoint + idIntervention,
          options: Options(responseType: ResponseType.json, headers: header));
      return InterventionDetailResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return InterventionDetailResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<int> refuseCompetition(String reference, String commentaire,
      int idIntervention, String uuidIntervention, String idUser) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      var params = {
        //"order": reference,
        "string": commentaire,
        //"user": idUser,
        //"id": idIntervention,
        "uuid": uuidIntervention
      };
      Response response = await _dio.put(refuseEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return 500;
    } catch (e) {
      throw e;
    }
  }

  Future<int> acceptIntervention(String reference, int idIntervention,
      String uuidIntervention, String idUser) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      var params = {
        //"order": reference,
        //"user": idUser,
        //"id": idIntervention,
        "uuid": uuidIntervention
      };
      Response response = await _dio.put(acceptEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
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
    Map<String, String> header = await headerFormatter.getHeader();
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
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return ResultMessageResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
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
    Map<String, String> header = await headerFormatter.getHeader();
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
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return AddAdressFacturationResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
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
    Map<String, String> header = await headerFormatter.getHeader();
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
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return AddAdressFacturationResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return AddAdressFacturationResponse(result: "KO", message: "erreur");
    } catch (e) {
      throw e;
    }
  }

  Future<ChangeOrderStateResponse> changeOrderState(
      num order, num orderState, String orderUuid) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      var params = {
        "order": order,
        "orderState": orderState,
      };
      Response response = await _dio.put(changeOrderStateEndPoint + orderUuid,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return ChangeOrderStateResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return ChangeOrderStateResponse(orderUpdated: false);
    } catch (e) {
      throw e;
    }
  }

  Future<GetTypesDocumentsResponse> getListesTypesDocuments() async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(getListeTyesDocumentsEndPoint,
          options: Options(responseType: ResponseType.json, headers: header));
      return GetTypesDocumentsResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return GetTypesDocumentsResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<GetTypesCommandesResponse> getListesTypesCommandes() async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      Response response = await _dio.get(getListeTypesCommandesEndPoint,
          options: Options(responseType: ResponseType.json, headers: header));
      return GetTypesCommandesResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return GetTypesCommandesResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<CreationNouvelleCommandeResponse> creationNouvelleCommande(
      String originalOrderUuid, String orderCaseUuid) async {
    Map<String, String> header = await headerFormatter.getHeader();
    try {
      var params = {
        "originalOrderUuid": originalOrderUuid,
        "orderCaseUuid": orderCaseUuid,
        "stateCode": "SCHEDULED", //optional
        "enabled": true //optional
      };
      Response response = await _dio.post(creationNouvelleCommandeEndPoint,
          options: Options(responseType: ResponseType.json, headers: header),
          data: jsonEncode(params));
      return CreationNouvelleCommandeResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await headerFormatter.tokenExpired();
      }
      return CreationNouvelleCommandeResponse(orderCreated: false);
    } catch (e) {
      throw e;
    }
  }
}

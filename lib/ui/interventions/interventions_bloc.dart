import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/models/responses/add_adresse_facturation_response.dart';
import 'package:mdp/models/responses/adressResponse.dart';
import 'package:mdp/models/responses/change_order_state.dart';
import 'package:mdp/models/responses/get_designations_name.dart';
import 'package:mdp/models/responses/get_devis_response.dart';
import 'package:mdp/models/responses/get_interventions.dart';
import 'package:mdp/models/responses/get_materials_response.dart';
import 'package:mdp/models/responses/get_types_documents_response.dart';
import 'package:mdp/models/responses/intervention_detail_response.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/models/responses/result_message_response.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:mdp/models/responses/units_response.dart';
import 'package:mdp/models/responses/upload_document_response.dart';
import 'package:mdp/network/repository/adress_repository.dart';
import 'package:mdp/network/repository/document_uploader_repository.dart';
import 'package:mdp/network/repository/intervention_repository.dart';
import 'package:mdp/network/repository/login_repository.dart';
import 'package:mdp/network/repository/redaction_devis_repository.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class InterventionsBloc extends Disposable {
  final controller = StreamController();
  final InterventionRepository _interventionRepository =
      InterventionRepository();
  final AdressRepository _adressRepository = AdressRepository();
  final SharedPref sharedPref = SharedPref();
  InterventionDetailResponse interventionDetail = InterventionDetailResponse();
  final changesNotifier = PublishSubject<bool>();
  List<ListQuoteReference> liste_names = <ListQuoteReference>[];
  List<ListWorkload> liste_materials = <ListWorkload>[];
  List<OrderDocumentTypes> liste_documents = <OrderDocumentTypes>[];
  List<ListWorkload> liste_mainDeplacement = <ListWorkload>[];
  List<ListWorkloadUnits> liste_units = <ListWorkloadUnits>[];
  List<String> liste_unit_names = <String>[];
  RedactionDevisRepository _redactionDevisRepository =
      RedactionDevisRepository();
  GetDevisResponse dernierDevis = GetDevisResponse();
  DocumentUploaderRepository _documentUploaderRepository =
      DocumentUploaderRepository();

  Future<GetInterventionsResponse> getInterventions(
      String subcontractorId, String code) async {
    GetInterventionsResponse resp =
        await _interventionRepository.getInterventions(subcontractorId, code);
    return resp;
  }

  Future<GetDesignationsNameResponse> getDesignationsName() async {
    liste_names.clear();
    GetDesignationsNameResponse resp =
        await _redactionDevisRepository.getDesignationsName();
    liste_names.addAll(resp.listQuoteReference);
    return resp;
  }

  Future<GetMaterialResponse> getMaterials() async {
    liste_materials.clear();
    GetMaterialResponse resp = await _redactionDevisRepository.getMaterials();
    liste_materials.addAll(resp.listWorkload);
    return resp;
  }

  Future<GetTypesDocumentsResponse> getTypesDocuments() async {
    liste_documents.clear();
    GetTypesDocumentsResponse resp =
        await _interventionRepository.getListesTypesDocuments();
    liste_documents.addAll(resp.orderDocumentTypes);
    return resp;
  }

  Future<GetMaterialResponse> getMainDeplacement() async {
    liste_mainDeplacement.clear();
    GetMaterialResponse resp =
        await _redactionDevisRepository.getMainDeplacement();
    liste_mainDeplacement.addAll(resp.listWorkload);
    return resp;
  }

  Future<GetUnitsResponse> getUnits() async {
    liste_units.clear();
    GetUnitsResponse resp = await _redactionDevisRepository.getUnits();
    liste_units.addAll(resp.listWorkloadUnits);
    liste_unit_names.clear();
    liste_units.forEach((element) {
      liste_unit_names.add(element.name);
    });
    return resp;
  }

  Future<ShowInterventionResponse> showIntervention(
      String idIntervention) async {
    ShowInterventionResponse response =
        await _interventionRepository.showIntervention(idIntervention);
    return response;
  }

  Future<InterventionDetailResponse> getInterventionDetail(
      String idIntervention) async {
    interventionDetail =
        await _interventionRepository.getInterventionDetail(idIntervention);
    if (interventionDetail.interventionDetail.quotes == null) {
      dernierDevis = null;
    } else {
      if (interventionDetail.interventionDetail.quotes.isEmpty) {
        dernierDevis = null;
      } else {
        //we compare between dates of quotes to get the last quote(devis)
        DateTime lastDateDevis = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(
            interventionDetail.interventionDetail.quotes.first.created.date);
        num lastIdDevis = interventionDetail.interventionDetail.quotes.first.id;
        interventionDetail.interventionDetail.quotes.forEach((element) {
          DateTime tempDate =
              new DateFormat("yyyy-MM-dd hh:mm:ss").parse(element.created.date);
          if (tempDate.isAfter(lastDateDevis)) {
            lastDateDevis = tempDate;
            lastIdDevis = element.id;
          }
        });
        await getDevisDetails(lastIdDevis.toString());
      }
    }
    changesNotifier.add(true);
  }

  Future<GetDevisResponse> getDevisDetails(String orderId) async {
    dernierDevis = await _redactionDevisRepository.getDevis(orderId);
    notifChanges();
    return dernierDevis;
  }

  Future<int> acceptIntervention(String reference, int idIntervention,
      String uuidIntervention, String idUser) async {
    int response = await _interventionRepository.acceptIntervention(
        reference, idIntervention, uuidIntervention, idUser);
    return response;
  }

  Future<int> refuseIntervention(String reference, String commentaire,
      int idIntervention, String uuidIntervention, String idUser) async {
    int response = await _interventionRepository.refuseIntervention(
        reference, commentaire, idIntervention, uuidIntervention, idUser);
    return response;
  }

  Future<ResultMessageResponse> modifCoordClient(
      String civility,
      String firstname,
      String lastname,
      String phonenumber,
      String mail,
      String uuidClient) async {
    return _interventionRepository.modifCoordClient(
        civility, firstname, lastname, phonenumber, mail, uuidClient);
  }

  Future<List<AdressResponse>> getCommunity(String zip) {
    return _adressRepository.getCommunity(zip);
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
    return _interventionRepository.addAddressFacturation(
        order,
        adressFirstname,
        adressLastName,
        streetNumber,
        streetName,
        additionalAddress,
        city,
        postcode);
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
    return _interventionRepository.modifierAddressFacturation(
        order,
        adressFirstname,
        adressLastName,
        streetNumber,
        streetName,
        additionalAddress,
        city,
        postcode);
  }

  Future<ChangeOrderStateResponse> changeOrderState(
      num order, num orderState, String orderUuid) async {
    return _interventionRepository.changeOrderState(
        order, orderState, orderUuid);
  }

  Future<UploadDocumentResponse> uploadPhotosIntervention(
      num orderId, String documentContent) async {
    return await _documentUploaderRepository.uploadInterventionDocument(
        orderId, 2, documentContent);
  }

  notifChanges() {
    changesNotifier.add(true);
  }

  dispose() {
    controller.close();
    changesNotifier.close();
  }
}

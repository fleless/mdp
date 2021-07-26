import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/models/responses/add_adresse_facturation_response.dart';
import 'package:mdp/models/responses/adressResponse.dart';
import 'package:mdp/models/responses/get_designations_name.dart';
import 'package:mdp/models/responses/get_materials_response.dart';
import 'package:mdp/models/responses/intervention_detail_response.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/models/responses/result_message_response.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:mdp/network/repository/adress_repository.dart';
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
  RedactionDevisRepository _redactionDevisRepository =
      RedactionDevisRepository();

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
    notifChanges();
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

  notifChanges() {
    changesNotifier.add(true);
  }

  dispose() {
    controller.close();
    changesNotifier.close();
  }
}

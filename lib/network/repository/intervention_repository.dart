import 'package:mdp/models/responses/add_adresse_facturation_response.dart';
import 'package:mdp/models/responses/change_order_state.dart';
import 'package:mdp/models/responses/get_interventions.dart';
import 'package:mdp/models/responses/get_types_documents_response.dart';
import 'package:mdp/models/responses/intervention_detail_response.dart';
import 'package:mdp/models/responses/result_message_response.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:mdp/network/api/intervention_api_provider.dart';

class InterventionRepository {
  InterventionApiProvider _apiProvider = new InterventionApiProvider();

  Future<GetInterventionsResponse> getInterventions(
      String subcontractorId, String code) async {
    return _apiProvider.getInterventions(subcontractorId, code);
  }

  Future<ShowInterventionResponse> showIntervention(String idIntervention) {
    return _apiProvider.showIntervention(idIntervention);
  }

  Future<int> acceptIntervention(String reference, int idIntervention,
      String uuidIntervention, String idUser) {
    return _apiProvider.acceptIntervention(
        reference, idIntervention, uuidIntervention, idUser);
  }

  Future<int> refuseIntervention(String reference, String commentaire,
      int idIntervention, String uuidIntervention, String idUser) {
    return _apiProvider.refuseCompetition(
        reference, commentaire, idIntervention, uuidIntervention, idUser);
  }

  Future<InterventionDetailResponse> getInterventionDetail(
      String idIntervention) {
    return _apiProvider.getInterventionDetail(idIntervention);
  }

  Future<ResultMessageResponse> modifCoordClient(
      String civility,
      String firstname,
      String lastname,
      String phonenumber,
      String mail,
      String uuidClient) async {
    return _apiProvider.modifCoordClient(
        civility, firstname, lastname, phonenumber, mail, uuidClient);
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
    return _apiProvider.addAddressFacturation(
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
    return _apiProvider.modifierAddressFacturation(
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
    return _apiProvider.changeOrderState(order, orderState, orderUuid);
  }

  Future<GetTypesDocumentsResponse> getListesTypesDocuments() async {
    return _apiProvider.getListesTypesDocuments();
  }
}

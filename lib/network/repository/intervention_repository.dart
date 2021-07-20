import 'package:mdp/models/responses/intervention_detail_response.dart';
import 'package:mdp/models/responses/result_message_response.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:mdp/network/api/intervention_api_provider.dart';

class InterventionRepository {
  InterventionApiProvider _apiProvider = new InterventionApiProvider();

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
}

import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:mdp/network/api/intervention_api_provider.dart';
import 'package:mdp/network/api/login_api_provider.dart';

class InterventionRepository {
  InterventionApiProvider _apiProvider = new InterventionApiProvider();

  Future<ShowInterventionResponse> showIntervention(String idIntervention) {
    return _apiProvider.showIntervention(idIntervention);
  }
}

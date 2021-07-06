import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/models/responses/intervention_detail_response.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:mdp/network/repository/intervention_repository.dart';
import 'package:mdp/network/repository/login_repository.dart';
import 'package:mdp/utils/shared_preferences.dart';

class InterventionsBloc extends Disposable {
  final controller = StreamController();
  final InterventionRepository _interventionRepository =
      InterventionRepository();
  final SharedPref sharedPref = SharedPref();
  InterventionDetailResponse interventionDetail = InterventionDetailResponse();

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

  dispose() {
    controller.close();
  }
}

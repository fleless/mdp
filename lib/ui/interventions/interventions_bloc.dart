import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_constants.dart';
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

  Future<ShowInterventionResponse> showIntervention(
      String idIntervention) async {
    ShowInterventionResponse response = await _interventionRepository.showIntervention(idIntervention);
    return response;
  }

  dispose() {
    controller.close();
  }

}

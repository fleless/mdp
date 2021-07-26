import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/models/responses/add_appointment_response.dart';
import 'package:mdp/models/responses/get_designations_name.dart';
import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:mdp/network/repository/rdv_repository.dart';
import 'package:mdp/network/repository/redaction_devis_repository.dart';

class RedactionDevisBloc extends Disposable {
  final controller = StreamController();
  RedactionDevisRepository _repository = RedactionDevisRepository();
  List<ListQuoteReference> liste_names = <ListQuoteReference>[];

  Future<GetDesignationsNameResponse> getDesignationsName() async {
    liste_names.clear();
    GetDesignationsNameResponse resp = await _repository.getDesignationsName();
    liste_names.addAll(resp.listQuoteReference);
    return resp;
  }

  dispose() {
    controller.close();
  }
}

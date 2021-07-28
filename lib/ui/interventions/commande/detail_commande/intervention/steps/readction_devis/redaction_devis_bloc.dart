import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/models/responses/add_appointment_response.dart';
import 'package:mdp/models/responses/add_new_material_response.dart';
import 'package:mdp/models/responses/get_designations_name.dart';
import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:mdp/network/repository/rdv_repository.dart';
import 'package:mdp/network/repository/redaction_devis_repository.dart';

class RedactionDevisBloc extends Disposable {
  final controller = StreamController();
  RedactionDevisRepository _repository = RedactionDevisRepository();

  Future<AddNewMaterialResponse> addNewMaterial(String name, String comment,
      int unit, int quantity, double unit_price) async {
    return _repository.addNewMaterial(
        name, comment, unit, quantity, unit_price);
  }

  dispose() {
    controller.close();
  }
}

import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/models/responses/intervention_detail_response.dart';
import 'package:mdp/network/repository/intervention_repository.dart';

class InterventionBloc extends Disposable {
  final controller = StreamController();
  int step = 1;


  dispose() {
    controller.close();
  }
}

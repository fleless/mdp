import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:mdp/network/repository/rdv_repository.dart';

class CalendarBloc extends Disposable {
  final controller = StreamController();
  final RdvRepository _rdvRepository = RdvRepository();

  Future<UserAppointmentsResponse> getUserAppointments(String idUser) async {
    UserAppointmentsResponse response =
    await _rdvRepository.getUserAppointments(idUser);
    return response;
  }

  dispose() {
    controller.close();
  }
}

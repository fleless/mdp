import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/models/responses/add_appointment_response.dart';
import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:mdp/network/repository/rdv_repository.dart';

class PriseRdvBloc extends Disposable {
  final controller = StreamController();
  final RdvRepository _rdvRepository = RdvRepository();
  List<ListVisitData> userOrderAppointmentsResponse;

  Future<UserAppointmentsResponse> getUserAppointments(String idUser) async {
    UserAppointmentsResponse response =
        await _rdvRepository.getUserAppointments(idUser);
    return response;
  }

  Future<UserAppointmentsResponse> getUserAppointmentsForSpecificOrder(
      String idUser, String orderId) async {
    UserAppointmentsResponse response = await _rdvRepository
        .getUserAppointmentsForSpecificOrder(idUser, orderId);
    userOrderAppointmentsResponse = response.listVisitData
        .where((element) => element.type == "Premiere visite")
        .toList();
    return response;
  }

  Future<AddAppointmentResponse> addAppointment(
      String title,
      String comment,
      int orderId,
      String subContractorId,
      String startDate,
      String endDate) async {
    AddAppointmentResponse response = await _rdvRepository.addFirstAppointment(
        title, comment, orderId, subContractorId, startDate, endDate);
    return response;
  }

  Future<AddAppointmentResponse> updateFirstAppointment(String title,
      String comment, String startDate, String endDate, String idRdv) async {
    AddAppointmentResponse response = await _rdvRepository
        .updateFirstAppointment(title, comment, startDate, endDate, idRdv);
    return response;
  }

  dispose() {
    controller.close();
  }
}

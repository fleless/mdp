import 'package:mdp/models/responses/add_appointment_response.dart';
import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:mdp/network/api/rdv_api_provider.dart';

class RdvRepository {
  RdvApiProvider _apiProvider = new RdvApiProvider();

  Future<UserAppointmentsResponse> getUserAppointments(String idUser) {
    return _apiProvider.getUserAppointments(idUser);
  }

  Future<UserAppointmentsResponse> getUserAppointmentsForSpecificOrder(String idUser, String orderId) {
    return _apiProvider.getUserAppointmentsForSpecificOrder(idUser, orderId);
  }

  Future<AddAppointmentResponse> addFirstAppointment(
      String title,
      String comment,
      int orderId,
      String subContractorId,
      String startDate,
      String endDate) {
    return _apiProvider.addFirstAppointment(
        title, comment, orderId, subContractorId, startDate, endDate);
  }
}

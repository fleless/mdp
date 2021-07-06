import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:mdp/network/api/rdv_api_provider.dart';

class RdvRepository {
  RdvApiProvider _apiProvider = new RdvApiProvider();

  Future<UserAppointmentsResponse> getUserAppointments(String idUser) {
    return _apiProvider.getUserAppointments(idUser);
  }
}

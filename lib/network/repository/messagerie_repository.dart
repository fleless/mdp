import 'package:mdp/models/responses/add_appointment_response.dart';
import 'package:mdp/models/responses/add_message_response.dart';
import 'package:mdp/models/responses/messagerie_response.dart';
import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:mdp/network/api/messagerie_api_provider.dart';
import 'package:mdp/network/api/rdv_api_provider.dart';

class MessagerieRepository {
  MessagerieApiProvider _apiProvider = new MessagerieApiProvider();

  Future<MessageResponse> getMessagesForOrder(String idCommande) {
    return _apiProvider.getMessages(idCommande);
  }

  Future<AddMessageResponse> sendMessage(String idCommande, String body) {
    return _apiProvider.sendMessage(idCommande, body);
  }
}

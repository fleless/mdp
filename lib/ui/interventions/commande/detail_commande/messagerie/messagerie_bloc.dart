import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/models/message.dart';
import 'package:mdp/models/responses/add_message_response.dart';
import 'package:mdp/models/responses/messagerie_response.dart';
import 'package:mdp/network/repository/messagerie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MessagerieBloc extends Disposable {
  final controller = StreamController();
  final BehaviorSubject<int> addingMessage = BehaviorSubject<int>();
  List<ListOrderMessage> listMessages = <ListOrderMessage>[];
  final MessagerieRepository _messagerieRepository = MessagerieRepository();

  Future<MessageResponse> getMessages(String idCommande) async {
    addingMessage.add(1);
    listMessages.clear();
    MessageResponse response =
        await _messagerieRepository.getMessagesForOrder(idCommande);
    listMessages.addAll(response.listOrderMessage);
    addingMessage.add(0);
    return response;
  }

  Future<AddMessageResponse> sendMessage(String idCommande, String body) async {
    AddMessageResponse response =
        await _messagerieRepository.sendMessage(idCommande, body);
    return response;
  }

  initBloc() {
    if (!addingMessage.isClosed) {
      addingMessage.add(0);
    }
  }

  dispose() {
    controller.close();
    addingMessage.close();
  }
}

import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/models/message.dart';
import 'package:rxdart/rxdart.dart';

class MessagerieBloc extends Disposable {
  final controller = StreamController();
  final BehaviorSubject<int> addingMessage = BehaviorSubject<int>();
  List<Message> listMessages = <Message>[];


  getMessages(){
    listMessages.clear();
    Message message1 = Message("3 mai à 13:10", "Isabelle R.",
        "Ask CDCR San Quintin State Prison 2008. We installed Purex dispensers throughout the prison to combat diseases…and it was a Roaring Success (as in Roaring Drunk) I mean we had Long lines of prisoners fist fighting to use them.");
    Message message2 = Message("3 mai à 13:10", "Isabelle R.",
        "Simultaneously we had a problem with prisoner drunkenness that we couldn’t figure out. I mean , the guards searched cells multiple times to no avail. Alcohol based exposures through inadvertently consuming hand sanitizer, have been observed to produce more negative side effects for children than non-alcohol based.");
    Message message3 = Message("3 mai à 13:10", "MesDépanneurs.fr",
        "Twenty 30-second applications within half an hour is well in excess of almost anyone’s use of a sanitizer.");
    listMessages.add(message1);
    listMessages.add(message2);
    listMessages.add(message3);
  }

  initBloc(){
    if (!addingMessage.isClosed){
      addingMessage.add(0);
    }
  }

  dispose() {
    controller.close();
    addingMessage.close();
  }
}

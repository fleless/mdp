import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';

class HomeBloc extends Disposable {
  final controller = StreamController();

  dispose() {
    controller.close();
  }

}

import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';

class InterventionBloc extends Disposable {
  final controller = StreamController();
  int step = 1;

  dispose() {
    controller.close();
  }
}

import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/models/responses/add_type_document_response.dart';
import 'package:mdp/network/repository/document_uploader_repository.dart';
import 'package:rxdart/rxdart.dart';

class FinalisationInterventionBloc extends Disposable {
  final controller = StreamController();
  final docChangesNotifier = PublishSubject<bool>();
  final DocumentUploaderRepository _documentRepository =
      DocumentUploaderRepository();

  Future<bool> addTypeDocument(String name) async {
    AddTypeDocumentResponse resp =
        await _documentRepository.addTypeDocument(name);
    return resp.orderDocumentTypeCreated ? true : false;
  }

  @override
  void dispose() {
    controller.close();
    docChangesNotifier.close();
  }
}

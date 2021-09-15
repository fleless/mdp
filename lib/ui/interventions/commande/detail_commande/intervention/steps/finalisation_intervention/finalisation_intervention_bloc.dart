import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/models/responses/add_type_document_response.dart';
import 'package:mdp/models/responses/payment/send_sms_payment_response.dart';
import 'package:mdp/models/responses/payment/start_payment_response.dart';
import 'package:mdp/network/repository/document_uploader_repository.dart';
import 'package:mdp/network/repository/payment_repository.dart';
import 'package:rxdart/rxdart.dart';

class FinalisationInterventionBloc extends Disposable {
  final controller = StreamController();
  final docChangesNotifier = PublishSubject<bool>();
  final DocumentUploaderRepository _documentRepository =
      DocumentUploaderRepository();
  final PaymentRepository _paymentRepository = PaymentRepository();

  Future<bool> addTypeDocument(String name) async {
    AddTypeDocumentResponse resp =
        await _documentRepository.addTypeDocument(name);
    return resp.orderDocumentTypeCreated ? true : false;
  }

  Future<bool> generatePVDocument(num orderIdentifier) async {
    return _documentRepository.generatePVDocument(orderIdentifier);
  }

  Future<StartPaymentResponse> startPayment(String orderCode) async {
    return _paymentRepository.startPayment(orderCode);
  }

  Future<SendSmsPaymentResponse> sendSmsPayment(
      String phone, String orderCode, String user) async {
    return await _paymentRepository.sendSmsPayment(phone, orderCode, user);
  }

  Future<SendSmsPaymentResponse> sendEmailPayment(
      String email, String orderCode, String user) async {
    return await _paymentRepository.sendEmailPayment(email, orderCode, user);
  }

  @override
  void dispose() {
    controller.close();
    docChangesNotifier.close();
  }
}

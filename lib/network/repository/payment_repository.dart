import 'package:mdp/models/responses/finish_payment_response.dart';
import 'package:mdp/models/responses/payment/send_sms_payment_response.dart';
import 'package:mdp/models/responses/payment/start_payment_response.dart';
import 'package:mdp/network/api/payment_api_provider.dart';

class PaymentRepository {
  PaymentApiProvider _apiProvider = new PaymentApiProvider();

  Future<StartPaymentResponse> startPayment(String orderCode) async {
    return await _apiProvider.startPayment(orderCode);
  }

  Future<SendSmsPaymentResponse> sendSmsPayment(
      String phone, String orderCode, String user) async {
    return await _apiProvider.sendSmsPayment(phone, orderCode, user);
  }

  Future<SendSmsPaymentResponse> sendEmailPayment(
      String email, String orderCode, String user) async {
    return await _apiProvider.sendEmailPayment(email, orderCode, user);
  }

  Future<FinishPaymentResponse> finishPayment(
      String orderCode, num paymentType) async {
    return await _apiProvider.finishPayment(orderCode, paymentType);
  }
}

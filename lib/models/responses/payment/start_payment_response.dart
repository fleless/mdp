class StartPaymentResponse {
  String orderCode;
  String paymentStatus;
  num amount;

  StartPaymentResponse({this.orderCode, this.paymentStatus, this.amount});

  StartPaymentResponse.fromJson(Map<String, dynamic> json) {
    orderCode = json['orderCode'];
    paymentStatus = json['paymentStatus'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderCode'] = this.orderCode;
    data['paymentStatus'] = this.paymentStatus;
    data['amount'] = this.amount;
    return data;
  }
}

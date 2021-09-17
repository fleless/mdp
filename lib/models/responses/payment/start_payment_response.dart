class StartPaymentResponse {
  String orderCode;
  String paymentStatus;
  num amount;
  num paymentId;

  StartPaymentResponse(
      {this.orderCode, this.paymentStatus, this.amount, this.paymentId});

  StartPaymentResponse.fromJson(Map<String, dynamic> json) {
    orderCode = json['orderCode'];
    paymentStatus = json['paymentStatus'];
    amount = json['amount'];
    paymentId = json['paymentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderCode'] = this.orderCode;
    data['paymentStatus'] = this.paymentStatus;
    data['amount'] = this.amount;
    data['paymentId'] = this.paymentId;
    return data;
  }
}

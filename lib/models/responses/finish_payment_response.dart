class FinishPaymentResponse {
  bool processOk;
  num response;

  FinishPaymentResponse({this.processOk, this.response});

  FinishPaymentResponse.fromJson(Map<String, dynamic> json) {
    processOk = json['processOk'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['processOk'] = this.processOk;
    data['response'] = this.response;
    return data;
  }
}

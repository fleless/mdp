class SendSmsPaymentResponse {
  bool success;
  List<Null> errors;

  SendSmsPaymentResponse({this.success, this.errors});

  SendSmsPaymentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['errors'] != null) {
      errors = new List<Null>();
      json['errors'].forEach((v) {
        //errors.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

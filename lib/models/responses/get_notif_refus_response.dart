class GetNotifRefusResponse {
  OrderMessage orderMessage;
  List<Null> errors;

  GetNotifRefusResponse({this.orderMessage, this.errors});

  GetNotifRefusResponse.fromJson(Map<String, dynamic> json) {
    orderMessage = json['order-message'] != null
        ? new OrderMessage.fromJson(json['order-message'])
        : null;
    if (json['errors'] != null) {
      errors = new List<Null>();
      json['errors'].forEach((v) {
        //errors.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderMessage != null) {
      data['order-message'] = this.orderMessage.toJson();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderMessage {
  num id;
  bool isReady;
  String subject;
  String body;
  String createdAt;

  OrderMessage(
      {this.id, this.isReady, this.subject, this.body, this.createdAt});

  OrderMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isReady = json['is_ready'];
    subject = json['subject'];
    body = json['body'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_ready'] = this.isReady;
    data['subject'] = this.subject;
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    return data;
  }
}

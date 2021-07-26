class MessageResponse {
  List<ListOrderMessage> listOrderMessage;
  List<Null> errors;

  MessageResponse({this.listOrderMessage, this.errors});

  MessageResponse.fromJson(Map<String, dynamic> json) {
    if (json['list-order-message'] != null) {
      listOrderMessage = new List<ListOrderMessage>();
      json['list-order-message'].forEach((v) {
        listOrderMessage.add(new ListOrderMessage.fromJson(v));
      });
    }
    if (json['errors'] != null) {
      errors = new List<Null>();
      json['errors'].forEach((v) {
        // errors.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listOrderMessage != null) {
      data['list-order-message'] =
          this.listOrderMessage.map((v) => v.toJson()).toList();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListOrderMessage {
  num id;
  num orderId;
  bool isRead;
  String typeId;
  String subject;
  String body;
  String created;
  String user;

  ListOrderMessage(
      {this.id,
      this.orderId,
      this.isRead,
      this.typeId,
      this.subject,
      this.body,
      this.created,
      this.user});

  ListOrderMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    isRead = json['is_read'];
    typeId = json['type_id'];
    subject = json['subject'];
    body = json['body'];
    created = json['created'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['is_read'] = this.isRead;
    data['type_id'] = this.typeId;
    data['subject'] = this.subject;
    data['body'] = this.body;
    data['created'] = this.created;
    data['user'] = this.user;
    return data;
  }
}

class GetNotificationsResponse {
  List<NotificationData> notificationData;
  List<Null> errors;

  GetNotificationsResponse({this.notificationData, this.errors});

  GetNotificationsResponse.fromJson(Map<String, dynamic> json) {
    if (json['notification_data'] != null) {
      notificationData = new List<NotificationData>();
      json['notification_data'].forEach((v) {
        notificationData.add(new NotificationData.fromJson(v));
      });
    }
    if (json['errors'] != null) {
      errors = new List<Null>();
      json['errors'].forEach((v) {
        //errors.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notificationData != null) {
      data['notification_data'] =
          this.notificationData.map((v) => v.toJson()).toList();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  String id;
  String title;
  String content;
  String type;
  String category;
  String targetElementUuid;
  Details details;

  NotificationData(
      {this.id,
      this.title,
      this.content,
      this.type,
      this.category,
      this.targetElementUuid,
      this.details});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    type = json['type'];
    category = json['category'];
    targetElementUuid = json['target_element_uuid'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['type'] = this.type;
    data['category'] = this.category;
    data['target_element_uuid'] = this.targetElementUuid;
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    return data;
  }
}

class Order {
  num id;
  String uuid;
  String code;

  Order({this.id, this.uuid, this.code});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['code'] = this.code;
    return data;
  }
}

class Details {
  Order order;

  Details({this.order});

  Details.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    return data;
  }
}

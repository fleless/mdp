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
  String target;
  String type;

  NotificationData({this.id, this.title, this.content, this.target, this.type});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    target = json['target_element_uuid'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['target_element_uuid'] = this.target;
    data['type'] = this.type;
    return data;
  }
}

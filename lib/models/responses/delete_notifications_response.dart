class DeleteNotificationsResponse {
  NotificationData notificationData;
  List<Null> errors;

  DeleteNotificationsResponse({this.notificationData, this.errors});

  DeleteNotificationsResponse.fromJson(Map<String, dynamic> json) {
    notificationData = json['notification_data'] != null
        ? new NotificationData.fromJson(json['notification_data'])
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
    if (this.notificationData != null) {
      data['notification_data'] = this.notificationData.toJson();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  String deleted;

  NotificationData({this.deleted});

  NotificationData.fromJson(Map<String, dynamic> json) {
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deleted'] = this.deleted;
    return data;
  }
}

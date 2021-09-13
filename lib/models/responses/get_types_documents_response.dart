class GetTypesDocumentsResponse {
  List<OrderDocumentTypes> orderDocumentTypes;
  List<Null> errors;

  GetTypesDocumentsResponse({this.orderDocumentTypes, this.errors});

  GetTypesDocumentsResponse.fromJson(Map<String, dynamic> json) {
    if (json['orderDocumentTypes'] != null) {
      orderDocumentTypes = new List<OrderDocumentTypes>();
      json['orderDocumentTypes'].forEach((v) {
        orderDocumentTypes.add(new OrderDocumentTypes.fromJson(v));
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
    if (this.orderDocumentTypes != null) {
      data['orderDocumentTypes'] =
          this.orderDocumentTypes.map((v) => v.toJson()).toList();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDocumentTypes {
  num id;
  String name;
  bool enabled;
  Created created;

  OrderDocumentTypes({this.id, this.name, this.enabled, this.created});

  OrderDocumentTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    enabled = json['enabled'];
    created =
        json['created'] != null ? new Created.fromJson(json['created']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['enabled'] = this.enabled;
    if (this.created != null) {
      data['created'] = this.created.toJson();
    }
    return data;
  }
}

class Created {
  String date;
  num timezoneType;
  String timezone;

  Created({this.date, this.timezoneType, this.timezone});

  Created.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}

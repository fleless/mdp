class AddTypeDocumentResponse {
  OrderDocumentType orderDocumentType;
  bool orderDocumentTypeCreated;
  List<Null> errors;

  AddTypeDocumentResponse(
      {this.orderDocumentType, this.orderDocumentTypeCreated, this.errors});

  AddTypeDocumentResponse.fromJson(Map<String, dynamic> json) {
    orderDocumentType = json['orderDocumentType'] != null
        ? new OrderDocumentType.fromJson(json['orderDocumentType'])
        : null;
    orderDocumentTypeCreated = json['orderDocumentTypeCreated'];
    if (json['errors'] != null) {
      errors = new List<Null>();
      json['errors'].forEach((v) {
        //errors.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDocumentType != null) {
      data['orderDocumentType'] = this.orderDocumentType.toJson();
    }
    data['orderDocumentTypeCreated'] = this.orderDocumentTypeCreated;
    if (this.errors != null) {
      // data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDocumentType {
  num id;
  String name;
  String slug;
  bool enabled;
  bool deleted;
  Created created;

  OrderDocumentType(
      {this.id,
      this.name,
      this.slug,
      this.enabled,
      this.deleted,
      this.created});

  OrderDocumentType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    enabled = json['enabled'];
    deleted = json['deleted'];
    created =
        json['created'] != null ? new Created.fromJson(json['created']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['enabled'] = this.enabled;
    data['deleted'] = this.deleted;
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

class AddAdressFacturationResponse {
  Address address;
  String result;
  String message;

  AddAdressFacturationResponse({this.address, this.result, this.message});

  AddAdressFacturationResponse.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    result = json['result'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['result'] = this.result;
    data['message'] = this.message;
    return data;
  }
}

class Address {
  num id;
  String uuid;
  String addressFirstname;
  String addressLastname;
  String streetNumber;
  String streetName;
  String additionalAddress;
  City city;
  Type type;

  Address(
      {this.id,
      this.uuid,
      this.addressFirstname,
      this.addressLastname,
      this.streetNumber,
      this.streetName,
      this.additionalAddress,
      this.city,
      this.type});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    addressFirstname = json['addressFirstname'];
    addressLastname = json['addressLastname'];
    streetNumber = json['streetNumber'];
    streetName = json['streetName'];
    additionalAddress = json['additionalAddress'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['addressFirstname'] = this.addressFirstname;
    data['addressLastname'] = this.addressLastname;
    data['streetNumber'] = this.streetNumber;
    data['streetName'] = this.streetName;
    data['additionalAddress'] = this.additionalAddress;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    return data;
  }
}

class City {
  num id;
  String name;
  String inseeCode;
  String postcode;
  String latitude;
  String longitude;
  String created;
  String modified;
  bool enabled;
  String deleted;

  City(
      {this.id,
      this.name,
      this.inseeCode,
      this.postcode,
      this.latitude,
      this.longitude,
      this.created,
      this.modified,
      this.enabled,
      this.deleted});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    inseeCode = json['inseeCode'];
    postcode = json['postcode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    created = json['created'];
    modified = json['modified'];
    enabled = json['enabled'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['inseeCode'] = this.inseeCode;
    data['postcode'] = this.postcode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['enabled'] = this.enabled;
    data['deleted'] = this.deleted;
    return data;
  }
}

class Type {
  num id;
  String name;
  String created;
  String modified;
  bool enabled;
  String deleted;

  Type(
      {this.id,
      this.name,
      this.created,
      this.modified,
      this.enabled,
      this.deleted});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    created = json['created'];
    modified = json['modified'];
    enabled = json['enabled'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['enabled'] = this.enabled;
    data['deleted'] = this.deleted;
    return data;
  }
}

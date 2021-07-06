class UserAppointmentsResponse {
  List<Data> data;
  int totalRecords;

  UserAppointmentsResponse({this.data, this.totalRecords});

  UserAppointmentsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    totalRecords = json['total-records'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total-records'] = this.totalRecords;
    return data;
  }
}

class Data {
  int id;
  String startDate;
  String endDate;
  Client client;
  Order order;

  Data({this.id, this.startDate, this.endDate, this.client, this.order});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.client != null) {
      data['client'] = this.client.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    return data;
  }
}

class Client {
  String firstName;
  String lastName;

  Client({this.firstName, this.lastName});

  Client.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class Order {
  String code;
  num id;
  Address address;

  Order({this.code, this.id, this.address});

  Order.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    id = json['id'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['id'] = this.id;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}

class Address {
  String no;
  String street;
  String cp;
  String city;
  String complement;

  Address({this.no, this.street, this.cp, this.city, this.complement});

  Address.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    street = json['street'];
    cp = json['cp'];
    city = json['city'];
    complement = json['complement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['street'] = this.street;
    data['cp'] = this.cp;
    data['city'] = this.city;
    data['complement'] = this.complement;
    return data;
  }
}

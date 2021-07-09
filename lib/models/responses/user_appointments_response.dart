class UserAppointmentsResponse {
  List<ListVisitData> listVisitData;
  List<Null> errors;

  UserAppointmentsResponse({this.listVisitData, this.errors});

  UserAppointmentsResponse.fromJson(Map<String, dynamic> json) {
    if (json['list-visit-data'] != null) {
      listVisitData = new List<ListVisitData>();
      json['list-visit-data'].forEach((v) {
        listVisitData.add(new ListVisitData.fromJson(v));
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
    if (this.listVisitData != null) {
      data['list-visit-data'] =
          this.listVisitData.map((v) => v.toJson()).toList();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListVisitData {
  int id;
  String startDate;
  String endDate;
  String type;
  String title;
  Client client;
  Order order;

  ListVisitData(
      {this.id,
      this.startDate,
      this.endDate,
      this.type,
      this.title,
      this.client,
      this.order});

  ListVisitData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    title = json['title'];
    type = json['type'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['title'] = this.title;
    data['type'] = this.type;
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
  String email;
  String mobile;

  Client({this.firstName, this.lastName, this.email, this.mobile});

  Client.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['Email'];
    mobile = json['Mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['Email'] = this.email;
    data['Mobile'] = this.mobile;
    return data;
  }
}

class Order {
  String code;
  int id;
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

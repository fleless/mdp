class ProfileResponse {
  Subcontractor subcontractor;
  List<Null> errors;

  ProfileResponse({this.subcontractor, this.errors});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    subcontractor = json['subcontractor'] != null
        ? new Subcontractor.fromJson(json['subcontractor'])
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
    if (this.subcontractor != null) {
      data['subcontractor'] = this.subcontractor.toJson();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcontractor {
  User user;
  Company company;
  Responsible responsible;

  Subcontractor({this.user, this.company, this.responsible});

  Subcontractor.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    responsible = json['responsible'] != null
        ? new Responsible.fromJson(json['responsible'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company.toJson();
    }
    if (this.responsible != null) {
      data['responsible'] = this.responsible.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String uuid;
  String firstName;
  String lastName;
  String mail;
  String myIdentity;

  User(
      {this.id,
      this.uuid,
      this.firstName,
      this.lastName,
      this.mail,
      this.myIdentity});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mail = json['mail'];
    myIdentity = json['myIdentity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mail'] = this.mail;
    data['myIdentity'] = this.myIdentity;
    return data;
  }
}

class Company {
  String name;
  String alias;

  Company({this.name, this.alias});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['alias'] = this.alias;
    return data;
  }
}

class Responsible {
  String firstName;
  String lastName;
  String mail;
  String phone;

  Responsible({this.firstName, this.lastName, this.mail, this.phone});

  Responsible.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    mail = json['mail'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mail'] = this.mail;
    data['phone'] = this.phone;
    return data;
  }
}

class GetAccountResponse {
  num id;
  String lastName;
  String firstName;
  String username;
  String email;
  String uuid;
  Profile profile;

  GetAccountResponse(
      {this.id,
      this.lastName,
      this.firstName,
      this.username,
      this.email,
      this.uuid,
      this.profile});

  GetAccountResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastName = json['lastName'];
    firstName = json['firstName'];
    username = json['username'];
    email = json['email'];
    uuid = json['uuid'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['uuid'] = this.uuid;
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    return data;
  }
}

class Profile {
  String uuid;
  String firstName;
  String lastName;
  String mail;
  String id;
  Subcontractor subcontractor;

  Profile(
      {this.uuid,
      this.firstName,
      this.lastName,
      this.mail,
      this.id,
      this.subcontractor});

  Profile.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mail = json['mail'];
    id = json['id'];
    subcontractor = json['subcontractor'] != null
        ? new Subcontractor.fromJson(json['subcontractor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mail'] = this.mail;
    data['id'] = this.id;
    if (this.subcontractor != null) {
      data['subcontractor'] = this.subcontractor.toJson();
    }
    return data;
  }
}

class Subcontractor {
  String uuid;
  num id;

  Subcontractor({this.uuid, this.id});

  Subcontractor.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['id'] = this.id;
    return data;
  }
}

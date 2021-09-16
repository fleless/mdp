class CreationNouvelleCommandeResponse {
  bool orderCreated;
  List<Null> errors;

  CreationNouvelleCommandeResponse({this.orderCreated, this.errors});

  CreationNouvelleCommandeResponse.fromJson(Map<String, dynamic> json) {
    orderCreated = json['orderCreated'];
    if (json['errors'] != null) {
      errors = new List<Null>();
      json['errors'].forEach((v) {
        // errors.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderCreated'] = this.orderCreated;
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

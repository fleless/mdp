class GetUnitsResponse {
  List<ListWorkloadUnits> listWorkloadUnits;
  List<Null> errors;

  GetUnitsResponse({this.listWorkloadUnits, this.errors});

  GetUnitsResponse.fromJson(Map<String, dynamic> json) {
    if (json['list-workload-units'] != null) {
      listWorkloadUnits = new List<ListWorkloadUnits>();
      json['list-workload-units'].forEach((v) {
        listWorkloadUnits.add(new ListWorkloadUnits.fromJson(v));
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
    if (this.listWorkloadUnits != null) {
      data['list-workload-units'] =
          this.listWorkloadUnits.map((v) => v.toJson()).toList();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListWorkloadUnits {
  int id;
  String name;
  String code;

  ListWorkloadUnits({this.id, this.name, this.code});

  ListWorkloadUnits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

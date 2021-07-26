class GetMaterialResponse {
  List<ListWorkload> listWorkload;
  List<Null> errors;

  GetMaterialResponse({this.listWorkload, this.errors});

  GetMaterialResponse.fromJson(Map<String, dynamic> json) {
    if (json['list-workload'] != null) {
      listWorkload = new List<ListWorkload>();
      json['list-workload'].forEach((v) {
        listWorkload.add(new ListWorkload.fromJson(v));
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
    if (this.listWorkload != null) {
      data['list-workload'] = this.listWorkload.map((v) => v.toJson()).toList();
    }
    if (this.errors != null) {
      // data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListWorkload {
  num id;
  String type;
  String name;
  num recommendedPrice;
  num maximumPrice;
  num recommendedQuantity;
  num maximumQuantity;
  String unitName;
  String unitCode;
  bool verified;
  bool enabled;

  ListWorkload(
      {this.id,
      this.type,
      this.name,
      this.recommendedPrice,
      this.maximumPrice,
      this.recommendedQuantity,
      this.maximumQuantity,
      this.unitName,
      this.unitCode,
      this.verified,
      this.enabled});

  ListWorkload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    recommendedPrice = json['recommended_price'];
    maximumPrice = json['maximum_price'];
    recommendedQuantity = json['recommended_quantity'];
    maximumQuantity = json['maximum_quantity'];
    unitName = json['unit_name'];
    unitCode = json['unit_code'];
    verified = json['verified'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['recommended_price'] = this.recommendedPrice;
    data['maximum_price'] = this.maximumPrice;
    data['recommended_quantity'] = this.recommendedQuantity;
    data['maximum_quantity'] = this.maximumQuantity;
    data['unit_name'] = this.unitName;
    data['unit_code'] = this.unitCode;
    data['verified'] = this.verified;
    data['enabled'] = this.enabled;
    return data;
  }
}

class AddNewMaterialResponse {
  WorkLoadData workLoadData;
  List<Null> errors;

  AddNewMaterialResponse({this.workLoadData, this.errors});

  AddNewMaterialResponse.fromJson(Map<String, dynamic> json) {
    workLoadData = json['work-load-data'] != null
        ? new WorkLoadData.fromJson(json['work-load-data'])
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
    if (this.workLoadData != null) {
      data['work-load-data'] = this.workLoadData.toJson();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkLoadData {
  num id;
  String name;
  String type;
  num recommendedPrice;
  num maximumPrice;
  num recommendedQuantity;
  num maximumQuantity;
  String unitName;
  String unitCode;
  bool verified;
  bool enabled;

  WorkLoadData(
      {this.id,
      this.name,
      this.type,
      this.recommendedPrice,
      this.maximumPrice,
      this.recommendedQuantity,
      this.maximumQuantity,
      this.unitName,
      this.unitCode,
      this.verified,
      this.enabled});

  WorkLoadData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
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
    data['name'] = this.name;
    data['type'] = this.type;
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

class GetTypesCommandesResponse {
  List<OrderCases> orderCases;
  num totalRecords;

  GetTypesCommandesResponse({this.orderCases, this.totalRecords});

  GetTypesCommandesResponse.fromJson(Map<String, dynamic> json) {
    if (json['orderCases'] != null) {
      orderCases = new List<OrderCases>();
      json['orderCases'].forEach((v) {
        orderCases.add(new OrderCases.fromJson(v));
      });
    }
    totalRecords = json['totalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderCases != null) {
      data['orderCases'] = this.orderCases.map((v) => v.toJson()).toList();
    }
    data['totalRecords'] = this.totalRecords;
    return data;
  }
}

class OrderCases {
  num id;
  String uuid;
  String name;
  String code;
  String description;
  num minDuration;
  num maxDuration;
  List<PriceItems> priceItems;
  List<Metas> metas;
  Category category;
  Domain domain;
  Domain type;
  Activity activity;
  bool enabled;
  num minprice;
  num maxprice;
  num maxpriceapproximate;
  num minpriceapproximate;

  OrderCases(
      {this.id,
      this.uuid,
      this.name,
      this.code,
      this.description,
      this.minDuration,
      this.maxDuration,
      this.priceItems,
      this.metas,
      this.category,
      this.domain,
      this.type,
      this.activity,
      this.enabled,
      this.minprice,
      this.maxprice,
      this.maxpriceapproximate,
      this.minpriceapproximate});

  OrderCases.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    minDuration = json['minDuration'];
    maxDuration = json['maxDuration'];
    if (json['priceItems'] != null) {
      priceItems = new List<PriceItems>();
      json['priceItems'].forEach((v) {
        priceItems.add(new PriceItems.fromJson(v));
      });
    }
    if (json['metas'] != null) {
      metas = new List<Metas>();
      json['metas'].forEach((v) {
        metas.add(new Metas.fromJson(v));
      });
    }
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    domain =
        json['domain'] != null ? new Domain.fromJson(json['domain']) : null;
    type = json['type'] != null ? new Domain.fromJson(json['type']) : null;
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
    enabled = json['enabled'];
    minprice = json['minprice'];
    maxprice = json['maxprice'];
    maxpriceapproximate = json['maxpriceapproximate'];
    minpriceapproximate = json['minpriceapproximate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    data['minDuration'] = this.minDuration;
    data['maxDuration'] = this.maxDuration;
    if (this.priceItems != null) {
      data['priceItems'] = this.priceItems.map((v) => v.toJson()).toList();
    }
    if (this.metas != null) {
      data['metas'] = this.metas.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.domain != null) {
      data['domain'] = this.domain.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    if (this.activity != null) {
      data['activity'] = this.activity.toJson();
    }
    data['enabled'] = this.enabled;
    data['minprice'] = this.minprice;
    data['maxprice'] = this.maxprice;
    data['maxpriceapproximate'] = this.maxpriceapproximate;
    data['minpriceapproximate'] = this.minpriceapproximate;
    return data;
  }
}

class PriceItems {
  num id;
  num maxPrice;
  num minPrice;
  String periodPrice;

  PriceItems({this.id, this.maxPrice, this.minPrice, this.periodPrice});

  PriceItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maxPrice = json['maxPrice'];
    minPrice = json['minPrice'];
    periodPrice = json['periodPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['maxPrice'] = this.maxPrice;
    data['minPrice'] = this.minPrice;
    data['periodPrice'] = this.periodPrice;
    return data;
  }
}

class Metas {
  num id;
  String name;
  String value;

  Metas({this.id, this.name, this.value});

  Metas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class Category {
  String uuid;
  String name;
  String code;
  bool enabled;
  num id;

  Category({this.uuid, this.name, this.code, this.enabled, this.id});

  Category.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    code = json['code'];
    enabled = json['enabled'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['code'] = this.code;
    data['enabled'] = this.enabled;
    data['id'] = this.id;
    return data;
  }
}

class Domain {
  String uuid;
  String name;
  String code;
  bool enabled;
  num id;

  Domain({this.uuid, this.name, this.code, this.enabled, this.id});

  Domain.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    code = json['code'];
    enabled = json['enabled'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['code'] = this.code;
    data['enabled'] = this.enabled;
    data['id'] = this.id;
    return data;
  }
}

class Activity {
  num id;
  String name;
  String color;
  bool enabled;

  Activity({this.id, this.name, this.color, this.enabled});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['enabled'] = this.enabled;
    return data;
  }
}

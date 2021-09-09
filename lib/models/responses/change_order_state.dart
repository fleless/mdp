class ChangeOrderStateResponse {
  Order order;
  bool orderUpdated;
  Errors errors;

  ChangeOrderStateResponse({this.order, this.orderUpdated, this.errors});

  ChangeOrderStateResponse.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    orderUpdated = json['orderUpdated'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    data['orderUpdated'] = this.orderUpdated;
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    return data;
  }
}

class Order {
  num id;
  String code;
  num amountInitial;
  num amountFinal;
  num amountToBlock;
  num amountToPay;
  String completionDate;
  num franchiseSum;
  num coveredSum;
  bool manualControl;
  String user;
  String description;
  num userId;
  String preferredVisitDate;
  bool deleted;

  Order(
      {this.id,
      this.code,
      this.amountInitial,
      this.amountFinal,
      this.amountToBlock,
      this.amountToPay,
      this.completionDate,
      this.franchiseSum,
      this.coveredSum,
      this.manualControl,
      this.user,
      this.description,
      this.userId,
      this.preferredVisitDate,
      this.deleted});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amountInitial = json['amountInitial'];
    amountFinal = json['amountFinal'];
    amountToBlock = json['amountToBlock'];
    amountToPay = json['amountToPay'];
    completionDate = json['completionDate'];
    franchiseSum = json['franchiseSum'];
    coveredSum = json['coveredSum'];
    manualControl = json['manualControl'];
    user = json['user'];
    description = json['description'];
    userId = json['userId'];
    preferredVisitDate = json['preferredVisitDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['amountInitial'] = this.amountInitial;
    data['amountFinal'] = this.amountFinal;
    data['amountToBlock'] = this.amountToBlock;
    data['amountToPay'] = this.amountToPay;
    data['completionDate'] = this.completionDate;
    data['franchiseSum'] = this.franchiseSum;
    data['coveredSum'] = this.coveredSum;
    data['manualControl'] = this.manualControl;
    data['user'] = this.user;
    data['description'] = this.description;
    data['userId'] = this.userId;
    data['preferredVisitDate'] = this.preferredVisitDate;
    data['deleted'] = this.deleted;
    return data;
  }
}

class Channel {
  num id;
  String name;

  Channel({this.id, this.name});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class State {
  int id;
  String code;
  String name;

  State({this.id, this.code, this.name});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}

class Source {
  int id;
  String name;
  String description;
  bool isMobile;

  Source({this.id, this.name, this.description, this.isMobile});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isMobile = json['isMobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['isMobile'] = this.isMobile;
    return data;
  }
}

class InterventionAddress {
  int id;
  String uuid;
  Null addressFirstname;
  Null addressLastname;
  String streetNumber;
  String streetName;
  double longitude;
  double latitude;
  City city;
  Channel type;

  InterventionAddress(
      {this.id,
      this.uuid,
      this.addressFirstname,
      this.addressLastname,
      this.streetNumber,
      this.streetName,
      this.longitude,
      this.latitude,
      this.city,
      this.type});

  InterventionAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    addressFirstname = json['addressFirstname'];
    addressLastname = json['addressLastname'];
    streetNumber = json['streetNumber'];
    streetName = json['streetName'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    type = json['type'] != null ? new Channel.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['addressFirstname'] = this.addressFirstname;
    data['addressLastname'] = this.addressLastname;
    data['streetNumber'] = this.streetNumber;
    data['streetName'] = this.streetName;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
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
  int id;
  String name;
  String inseeCode;
  String postcode;
  String latitude;
  String longitude;
  Department department;

  City(
      {this.id,
      this.name,
      this.inseeCode,
      this.postcode,
      this.latitude,
      this.longitude,
      this.department});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    inseeCode = json['inseeCode'];
    postcode = json['postcode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['inseeCode'] = this.inseeCode;
    data['postcode'] = this.postcode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.department != null) {
      data['department'] = this.department.toJson();
    }
    return data;
  }
}

class Department {
  int id;
  String name;
  String code;
  Region region;

  Department({this.id, this.name, this.code, this.region});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    region =
        json['region'] != null ? new Region.fromJson(json['region']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    if (this.region != null) {
      data['region'] = this.region.toJson();
    }
    return data;
  }
}

class Region {
  int id;
  String name;
  String code;
  State country;

  Region({this.id, this.name, this.code, this.country});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    country =
        json['country'] != null ? new State.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    return data;
  }
}

class Details {
  int id;
  int price;
  int quantity;
  String name;
  String description;
  Ordercase ordercase;

  Details(
      {this.id,
      this.price,
      this.quantity,
      this.name,
      this.description,
      this.ordercase});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    quantity = json['quantity'];
    name = json['name'];
    description = json['description'];
    ordercase = json['ordercase'] != null
        ? new Ordercase.fromJson(json['ordercase'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.ordercase != null) {
      data['ordercase'] = this.ordercase.toJson();
    }
    return data;
  }
}

class Ordercase {
  int id;
  String uuid;
  String name;
  Null slug;
  String code;
  String description;
  int minDuration;
  int maxDuration;
  Category category;
  Domain domain;
  Channel type;
  Activity activity;
  bool enabled;
  Null deleted;
  int minprice;
  int maxprice;
  int maxpriceapproximate;
  int minpriceapproximate;

  Ordercase({
    this.id,
    this.uuid,
    this.name,
    this.slug,
    this.code,
    this.description,
    this.minDuration,
    this.maxDuration,
    this.category,
    this.domain,
    this.type,
    this.activity,
    this.enabled,
    this.deleted,
    this.minprice,
    this.maxprice,
    this.maxpriceapproximate,
    this.minpriceapproximate,
  });

  Ordercase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    slug = json['slug'];
    code = json['code'];
    description = json['description'];
    minDuration = json['minDuration'];
    maxDuration = json['maxDuration'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    domain =
        json['domain'] != null ? new Domain.fromJson(json['domain']) : null;
    type = json['type'] != null ? new Channel.fromJson(json['type']) : null;
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
    enabled = json['enabled'];
    deleted = json['deleted'];
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
    data['slug'] = this.slug;
    data['code'] = this.code;
    data['description'] = this.description;
    data['minDuration'] = this.minDuration;
    data['maxDuration'] = this.maxDuration;
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
    data['deleted'] = this.deleted;
    data['minprice'] = this.minprice;
    data['maxprice'] = this.maxprice;
    data['maxpriceapproximate'] = this.maxpriceapproximate;
    data['minpriceapproximate'] = this.minpriceapproximate;
    return data;
  }
}

class Category {
  num id;
  String uuid;
  String name;
  String code;
  bool enabled;

  Category({this.id, this.uuid, this.name, this.code, this.enabled});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    code = json['code'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['code'] = this.code;
    data['enabled'] = this.enabled;
    return data;
  }
}

class Domain {
  num id;
  String uuid;
  String name;
  String code;
  bool enabled;

  Domain({this.id, this.uuid, this.name, this.code, this.enabled});

  Domain.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    code = json['code'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['code'] = this.code;
    data['enabled'] = this.enabled;
    return data;
  }
}

class Activity {
  num id;
  String name;
  bool enabled;

  Activity({this.id, this.name, this.enabled});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['enabled'] = this.enabled;
    return data;
  }
}

class Errors {
  String exception;

  Errors({this.exception});

  Errors.fromJson(Map<String, dynamic> json) {
    exception = json['exception'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exception'] = this.exception;
    return data;
  }
}

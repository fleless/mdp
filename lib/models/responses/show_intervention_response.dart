class ShowInterventionResponse {
  Intervention intervention;
  List<Null> errors;

  ShowInterventionResponse({this.intervention, this.errors});

  ShowInterventionResponse.fromJson(Map<String, dynamic> json) {
    intervention = json['intervention'] != null
        ? new Intervention.fromJson(json['intervention'])
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
    if (this.intervention != null) {
      data['intervention'] = this.intervention.toJson();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Intervention {
  int id;
  String uuid;
  String code;
  int amountInitial;
  Null amountFinal;
  int amountToBlock;
  Null amountToPay;
  int franchiseSum;
  int coveredSum;
  int totalMinPrice;
  int totalMaxPrice;
  PreferredVisitDate preferredVisitDate;
  Partner partner;
  InterventionAddress interventionAddress;
  String description;
  List<String> clientPhotos;
  List<Details> details;
  String indication;

  Intervention(
      {this.id,
        this.uuid,
        this.code,
        this.amountInitial,
        this.amountFinal,
        this.amountToBlock,
        this.amountToPay,
        this.franchiseSum,
        this.coveredSum,
        this.totalMinPrice,
        this.totalMaxPrice,
        this.preferredVisitDate,
        this.partner,
        this.interventionAddress,
        this.description,
        this.clientPhotos,
        this.details,
        this.indication});

  Intervention.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    code = json['code'];
    amountInitial = json['amountInitial'];
    amountFinal = json['amountFinal'];
    amountToBlock = json['amountToBlock'];
    amountToPay = json['amountToPay'];
    franchiseSum = json['franchiseSum'];
    coveredSum = json['coveredSum'];
    totalMinPrice = json['totalMinPrice'];
    totalMaxPrice = json['totalMaxPrice'];
    preferredVisitDate = json['preferredVisitDate'] != null
        ? new PreferredVisitDate.fromJson(json['preferredVisitDate'])
        : null;
    partner =
    json['partner'] != null ? new Partner.fromJson(json['partner']) : null;
    interventionAddress = json['interventionAddress'] != null
        ? new InterventionAddress.fromJson(json['interventionAddress'])
        : null;
    description = json['description'];
    clientPhotos = json['clientPhotos'].cast<String>();
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    indication = json['indication'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['code'] = this.code;
    data['amountInitial'] = this.amountInitial;
    data['amountFinal'] = this.amountFinal;
    data['amountToBlock'] = this.amountToBlock;
    data['amountToPay'] = this.amountToPay;
    data['franchiseSum'] = this.franchiseSum;
    data['coveredSum'] = this.coveredSum;
    data['totalMinPrice'] = this.totalMinPrice;
    data['totalMaxPrice'] = this.totalMaxPrice;
    if (this.preferredVisitDate != null) {
      data['preferredVisitDate'] = this.preferredVisitDate.toJson();
    }
    if (this.partner != null) {
      data['partner'] = this.partner.toJson();
    }
    if (this.interventionAddress != null) {
      data['interventionAddress'] = this.interventionAddress.toJson();
    }
    data['description'] = this.description;
    data['clientPhotos'] = this.clientPhotos;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['indication'] = this.indication;
    return data;
  }
}

class PreferredVisitDate {
  String date;
  int timezoneType;
  String timezone;

  PreferredVisitDate({this.date, this.timezoneType, this.timezone});

  PreferredVisitDate.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}

class Partner {
  String name;
  String alias;

  Partner({this.name, this.alias});

  Partner.fromJson(Map<String, dynamic> json) {
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

class InterventionAddress {
  String streetName;
  City city;

  InterventionAddress({this.streetName, this.city});

  InterventionAddress.fromJson(Map<String, dynamic> json) {
    streetName = json['streetName'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streetName'] = this.streetName;
    if (this.city != null) {
      data['city'] = this.city.toJson();
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
  Country country;

  Region({this.id, this.name, this.code, this.country});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
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

class Country {
  int id;
  String name;
  String code;

  Country({this.id, this.name, this.code});

  Country.fromJson(Map<String, dynamic> json) {
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

class Details {
  int price;
  int quantity;
  Ordercase ordercase;

  Details({this.price, this.quantity, this.ordercase});

  Details.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    quantity = json['quantity'];
    ordercase = json['ordercase'] != null
        ? new Ordercase.fromJson(json['ordercase'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    if (this.ordercase != null) {
      data['ordercase'] = this.ordercase.toJson();
    }
    return data;
  }
}

class Ordercase {
  String name;
  String code;
  String description;
  Domain domain;
  Domain type;
  int minprice;
  int maxprice;

  Ordercase(
      {this.name,
        this.code,
        this.description,
        this.domain,
        this.type,
        this.minprice,
        this.maxprice});

  Ordercase.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    description = json['description'];
    domain =
    json['domain'] != null ? new Domain.fromJson(json['domain']) : null;
    type = json['type'] != null ? new Domain.fromJson(json['type']) : null;
    minprice = json['minprice'];
    maxprice = json['maxprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    if (this.domain != null) {
      data['domain'] = this.domain.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    data['minprice'] = this.minprice;
    data['maxprice'] = this.maxprice;
    return data;
  }
}

class Domain {
  Null uuid;
  String name;
  String code;
  bool enabled;

  Domain({this.uuid, this.name, this.code, this.enabled});

  Domain.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    code = json['code'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['code'] = this.code;
    data['enabled'] = this.enabled;
    return data;
  }
}

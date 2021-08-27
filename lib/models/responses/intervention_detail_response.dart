class InterventionDetailResponse {
  InterventionDetail interventionDetail;
  List<dynamic> errors;

  InterventionDetailResponse({this.interventionDetail, this.errors});

  InterventionDetailResponse.fromJson(Map<String, dynamic> json) {
    interventionDetail = json['interventionDetail'] != null
        ? new InterventionDetail.fromJson(json['interventionDetail'])
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
    if (this.interventionDetail != null) {
      data['interventionDetail'] = this.interventionDetail.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InterventionDetail {
  num id;
  String uuid;
  String code;
  num amountInitial;
  num amountFinal;
  num amountToBlock;
  num amountToPay;
  num franchiseSum;
  num coveredSum;
  num totalMinPrice;
  num totalMaxPrice;
  PreferredVisitDate preferredVisitDate;
  State state;
  Partner partner;
  InterventionAddress interventionAddress;
  InterventionAddress invoicingAddress;
  Clients clients;
  String description;
  List<String> clientPhotos;
  List<Details> details;
  String indication;
  List<Subcontractors> subcontractors;
  List<Quotes> quotes;

  InterventionDetail(
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
      this.state,
      this.partner,
      this.interventionAddress,
      this.invoicingAddress,
      this.clients,
      this.description,
      this.clientPhotos,
      this.details,
      this.indication,
      this.subcontractors,
      this.quotes});

  InterventionDetail.fromJson(Map<String, dynamic> json) {
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
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    partner =
        json['partner'] != null ? new Partner.fromJson(json['partner']) : null;
    interventionAddress = json['interventionAddress'] != null
        ? new InterventionAddress.fromJson(json['interventionAddress'])
        : null;
    invoicingAddress = json['invoicingAddress'] != null
        ? new InterventionAddress.fromJson(json['invoicingAddress'])
        : null;
    clients =
        json['clients'] != null ? new Clients.fromJson(json['clients']) : null;
    description = json['description'];
    clientPhotos = json['clientPhotos'].cast<String>();
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    indication = json['indication'];
    if (json['subcontractors'] != null) {
      subcontractors = <Subcontractors>[];
      json['subcontractors'].forEach((v) {
        subcontractors.add(new Subcontractors.fromJson(v));
      });
    }
    if (json['quotes'] != null) {
      quotes = <Quotes>[];
      json['quotes'].forEach((v) {
        quotes.add(new Quotes.fromJson(v));
      });
    }
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
    if (this.state != null) {
      data['state'] = this.state.toJson();
    }
    if (this.partner != null) {
      data['partner'] = this.partner.toJson();
    }
    if (this.interventionAddress != null) {
      data['interventionAddress'] = this.interventionAddress.toJson();
    }
    if (this.invoicingAddress != null) {
      data['invoicingAddress'] = this.invoicingAddress.toJson();
    }
    if (this.clients != null) {
      data['clients'] = this.clients.toJson();
    }
    data['description'] = this.description;
    data['clientPhotos'] = this.clientPhotos;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['indication'] = this.indication;
    if (this.subcontractors != null) {
      data['subcontractors'] =
          this.subcontractors.map((v) => v.toJson()).toList();
    }
    if (this.quotes != null) {
      data['quotes'] = this.quotes.map((v) => v.toJson()).toList();
    }
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

class State {
  int id;
  String name;

  State({this.id, this.name});

  State.fromJson(Map<String, dynamic> json) {
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

class Partner {
  String name;
  String alias;
  List<dynamic> addresses;
  List<dynamic> commchannels;

  Partner({this.name, this.alias, this.addresses, this.commchannels});

  Partner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alias = json['alias'];
    if (json['addresses'] != null) {
      addresses = new List<Null>();
      json['addresses'].forEach((v) {
        // addresses.add(new Null.fromJson(v));
      });
    }
    if (json['commchannels'] != null) {
      commchannels = new List<Null>();
      json['commchannels'].forEach((v) {
        // commchannels.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['alias'] = this.alias;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    if (this.commchannels != null) {
      data['commchannels'] = this.commchannels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InterventionAddress {
  num id;
  String uuid;
  String addressFirstname;
  String addressLastname;
  String streetNumber;
  String streetName;
  num longitude;
  num latitude;
  City city;
  Type type;

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
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
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
  num id;
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
  num id;
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
  num id;
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
  num id;
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

class Clients {
  num id;
  String uuid;
  String nameOld;
  String civility;
  String firstname;
  String lastname;
  List<Commchannels> commchannels;
  List<Addresses> addresses;

  Clients(
      {this.id,
      this.uuid,
      this.civility,
      this.firstname,
      this.lastname,
      this.nameOld,
      this.commchannels,
      this.addresses});

  Clients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    civility = json['civility'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    nameOld = json['nameOld'];
    if (json['commchannels'] != null) {
      commchannels = new List<Commchannels>();
      json['commchannels'].forEach((v) {
        commchannels.add(new Commchannels.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['civility'] = this.civility;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['nameOld'] = this.nameOld;
    if (this.commchannels != null) {
      data['commchannels'] = this.commchannels.map((v) => v.toJson()).toList();
    }
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Commchannels {
  num id;
  String name;
  Type type;
  bool enabled;
  String password;
  bool preferred;

  Commchannels(
      {this.id,
      this.name,
      this.type,
      this.enabled,
      this.password,
      this.preferred});

  Commchannels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    enabled = json['enabled'];
    password = json['password'];
    preferred = json['preferred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    data['enabled'] = this.enabled;
    data['password'] = this.password;
    data['preferred'] = this.preferred;
    return data;
  }
}

class Type {
  num id;
  String name;
  bool enabled;
  bool deleted;

  Type({this.id, this.name, this.enabled, this.deleted});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    enabled = json['enabled'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['enabled'] = this.enabled;
    data['deleted'] = this.deleted;
    return data;
  }
}

class Addresses {
  num id;
  String streetNumber;
  String streetName;
  num longitude;
  num latitude;
  Type type;

  Addresses(
      {this.id,
      this.streetNumber,
      this.streetName,
      this.longitude,
      this.latitude,
      this.type});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    streetNumber = json['streetNumber'];
    streetName = json['streetName'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['streetNumber'] = this.streetNumber;
    data['streetName'] = this.streetName;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    return data;
  }
}

class Details {
  num price;
  num quantity;
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
  Type type;
  num minprice;
  num maxprice;

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
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
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
  String uuid;
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

class Subcontractors {
  num id;
  bool automaticProposition;
  bool geolocationAllowed;
  bool automaticInvoiceGenerationAllowed;
  num automaticInvoiceGenerationNextNumber;
  bool subjectToVat;
  bool providedWithTablet;
  num rankOffer;
  Company company;

  Subcontractors(
      {this.id,
      this.automaticProposition,
      this.geolocationAllowed,
      this.automaticInvoiceGenerationAllowed,
      this.automaticInvoiceGenerationNextNumber,
      this.subjectToVat,
      this.providedWithTablet,
      this.rankOffer,
      this.company});

  Subcontractors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    automaticProposition = json['automaticProposition'];
    geolocationAllowed = json['geolocationAllowed'];
    automaticInvoiceGenerationAllowed =
        json['automaticInvoiceGenerationAllowed'];
    automaticInvoiceGenerationNextNumber =
        json['automaticInvoiceGenerationNextNumber'];
    subjectToVat = json['subjectToVat'];
    providedWithTablet = json['providedWithTablet'];
    rankOffer = json['rankOffer'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['automaticProposition'] = this.automaticProposition;
    data['geolocationAllowed'] = this.geolocationAllowed;
    data['automaticInvoiceGenerationAllowed'] =
        this.automaticInvoiceGenerationAllowed;
    data['automaticInvoiceGenerationNextNumber'] =
        this.automaticInvoiceGenerationNextNumber;
    data['subjectToVat'] = this.subjectToVat;
    data['providedWithTablet'] = this.providedWithTablet;
    data['rankOffer'] = this.rankOffer;
    if (this.company != null) {
      data['company'] = this.company.toJson();
    }
    return data;
  }
}

class Company {
  String name;
  String alias;
  List<Addresses> addresses;
  List<Commchannels> commchannels;

  Company({this.name, this.alias, this.addresses, this.commchannels});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alias = json['alias'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    if (json['commchannels'] != null) {
      commchannels = new List<Commchannels>();
      json['commchannels'].forEach((v) {
        commchannels.add(new Commchannels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['alias'] = this.alias;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    if (this.commchannels != null) {
      data['commchannels'] = this.commchannels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quotes {
  num id;
  String name;
  String state;
  Created created;

  Quotes({this.id, this.name, this.state, this.created});

  Quotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    created =
        json['created'] != null ? new Created.fromJson(json['created']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    if (this.created != null) {
      data['created'] = this.created.toJson();
    }
    return data;
  }
}

class Created {
  String date;
  num timezoneType;
  String timezone;

  Created({this.date, this.timezoneType, this.timezone});

  Created.fromJson(Map<String, dynamic> json) {
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

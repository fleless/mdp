class GetDevisResponse {
  QuoteData quoteData;
  List<Null> errors;

  GetDevisResponse({this.quoteData, this.errors});

  GetDevisResponse.fromJson(Map<String, dynamic> json) {
    quoteData = json['quote_data'] != null
        ? new QuoteData.fromJson(json['quote_data'])
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
    if (this.quoteData != null) {
      data['quote_data'] = this.quoteData.toJson();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuoteData {
  Quote quote;
  List<Designations> designations;
  List<Documents> documents;

  QuoteData({this.quote, this.designations, this.documents});

  QuoteData.fromJson(Map<String, dynamic> json) {
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
    if (json['designations'] != null) {
      designations = new List<Designations>();
      json['designations'].forEach((v) {
        designations.add(new Designations.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quote != null) {
      data['quote'] = this.quote.toJson();
    }
    if (this.designations != null) {
      data['designations'] = this.designations.map((v) => v.toJson()).toList();
    }
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quote {
  num id;
  num orderId;
  num discount;
  num franchise;
  num coveredSum;
  num amountToPay;
  num reducedSum;
  StateDevis state;
  num advancePaymentSum;
  String promoCode;
  String vat;
  num totalHt;
  num vatAmount;
  num totalTtc;

  Quote(
      {this.id,
      this.discount,
      this.franchise,
      this.coveredSum,
      this.amountToPay,
      this.vat,
      this.reducedSum,
      this.promoCode,
      this.state,
      this.advancePaymentSum,
      this.totalHt,
      this.vatAmount,
      this.totalTtc});

  Quote.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discount = json['discount'];
    franchise = json['franchise'];
    coveredSum = json['covered_Sum'];
    amountToPay = json['amount_to_pay'];
    vat = json['vat'];
    reducedSum = json['reduced_sum'];
    promoCode = json['promo_code'];
    state =
        json['state'] != null ? new StateDevis.fromJson(json['state']) : null;
    advancePaymentSum = json['advance_payment_sum'];
    totalHt = json['total_ht'];
    vatAmount = json['vat_amount'];
    totalTtc = json['total_ttc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount'] = this.discount;
    data['franchise'] = this.franchise;
    data['covered_Sum'] = this.coveredSum;
    data['amount_to_pay'] = this.amountToPay;
    data['vat'] = this.vat;
    data['reduced_sum'] = this.reducedSum;
    data['promo_code'] = this.promoCode;
    if (this.state != null) {
      data['state'] = this.state.toJson();
    }
    data['advance_payment_sum'] = this.advancePaymentSum;
    data['total_ht'] = this.totalHt;
    data['vat_amount'] = this.vatAmount;
    data['total_ttc'] = this.totalTtc;
    return data;
  }
}

class Designations {
  QuoteReference quoteReference;
  List<Details> details;
  List<Photos> photos;

  Designations({this.quoteReference, this.details, this.photos});

  Designations.fromJson(Map<String, dynamic> json) {
    quoteReference = json['quote_reference'] != null
        ? new QuoteReference.fromJson(json['quote_reference'])
        : null;
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quoteReference != null) {
      data['quote_reference'] = this.quoteReference.toJson();
    }
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuoteReference {
  num id;
  String designation;

  QuoteReference({this.id, this.designation});

  QuoteReference.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['designation'] = this.designation;
    return data;
  }
}

class Details {
  num id;
  num workchangeId;
  String name;
  num quantity;
  num priceHt;
  num vat;
  num sort;
  String comment;

  Details(
      {this.id,
      this.workchangeId,
      this.name,
      this.quantity,
      this.priceHt,
      this.vat,
      this.sort,
      this.comment});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workchangeId = json['workchange_id'];
    name = json['name'];
    quantity = json['quantity'];
    priceHt = json['price_ht'];
    vat = json['vat'];
    sort = json['sort'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workchange_id'] = this.workchangeId;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price_ht'] = this.priceHt;
    data['vat'] = this.vat;
    data['sort'] = this.sort;
    data['comment'] = this.comment;
    return data;
  }
}

class Photos {
  num id;
  String document;
  String url;

  Photos({this.id, this.document, this.url});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    document = json['document'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['document'] = this.document;
    data['url'] = this.url;
    return data;
  }
}

class StateDevis {
  num id;
  String name;
  String code;

  StateDevis({this.id, this.name, this.code});

  StateDevis.fromJson(Map<String, dynamic> json) {
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

class Documents {
  num id;
  String documentType;
  String document;
  String url;

  Documents({this.id, this.documentType, this.document, this.url});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentType = json['document_type'];
    document = json['document'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['document_type'] = this.documentType;
    data['document'] = this.document;
    data['url'] = this.url;
    return data;
  }
}

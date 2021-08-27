class AddDesignationResponse {
  QuoteDetailsData quoteDetailsData;
  List<Null> errors;

  AddDesignationResponse({this.quoteDetailsData, this.errors});

  AddDesignationResponse.fromJson(Map<String, dynamic> json) {
    quoteDetailsData = json['quote-details-data'] != null
        ? new QuoteDetailsData.fromJson(json['quote-details-data'])
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
    if (this.quoteDetailsData != null) {
      data['quote-details-data'] = this.quoteDetailsData.toJson();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuoteDetailsData {
  num quoteId;
  QuoteReference quoteReference;
  List<Lines> lines;
  List<Photos> photos;

  QuoteDetailsData(
      {this.quoteId, this.quoteReference, this.lines, this.photos});

  QuoteDetailsData.fromJson(Map<String, dynamic> json) {
    quoteId = json['quote_id'];
    quoteReference = json['quote_reference'] != null
        ? new QuoteReference.fromJson(json['quote_reference'])
        : null;
    if (json['lines'] != null) {
      lines = new List<Lines>();
      json['lines'].forEach((v) {
        lines.add(new Lines.fromJson(v));
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
    data['quote_id'] = this.quoteId;
    if (this.quoteReference != null) {
      data['quote_reference'] = this.quoteReference.toJson();
    }
    if (this.lines != null) {
      data['lines'] = this.lines.map((v) => v.toJson()).toList();
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

class Lines {
  num id;
  num workchargeId;
  String name;
  num quantity;
  num priceHt;
  num sort;
  String comment;

  Lines(
      {this.id,
      this.workchargeId,
      this.name,
      this.quantity,
      this.priceHt,
      this.sort,
      this.comment});

  Lines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workchargeId = json['workcharge_id'];
    name = json['name'];
    quantity = json['quantity'];
    priceHt = json['price_ht'];
    sort = json['sort'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workcharge_id'] = this.workchargeId;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price_ht'] = this.priceHt;
    data['sort'] = this.sort;
    data['comment'] = this.comment;
    return data;
  }
}

class Photos {
  num quotePhotoId;
  String photoId;
  String url;

  Photos({this.quotePhotoId, this.photoId, this.url});

  Photos.fromJson(Map<String, dynamic> json) {
    quotePhotoId = json['quote_photo_id'];
    photoId = json['photo_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quote_photo_id'] = this.quotePhotoId;
    data['photo_id'] = this.photoId;
    data['url'] = this.url;
    return data;
  }
}

class AddDesignationRequest {
  Quote quote;
  QuoteReference quoteReference;
  String name;
  List<Photos> photos;
  List<Lines> lines;

  AddDesignationRequest(
      {this.quote, this.quoteReference, this.name, this.photos, this.lines});

  AddDesignationRequest.fromJson(Map<String, dynamic> json) {
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
    quoteReference = json['quote_reference'] != null
        ? new QuoteReference.fromJson(json['quote_reference'])
        : null;
    name = json['name'];
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    if (json['lines'] != null) {
      lines = new List<Lines>();
      json['lines'].forEach((v) {
        lines.add(new Lines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quote != null) {
      data['quote'] = this.quote.toJson();
    }
    if (this.quoteReference != null) {
      data['quote_reference'] = this.quoteReference.toJson();
    }
    data['name'] = this.name;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    if (this.lines != null) {
      data['lines'] = this.lines.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quote {
  num type;
  num order;
  num state;
  num id;
  String name;

  Quote({this.type, this.order, this.state, this.id, this.name});

  Quote.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    order = json['order'];
    state = json['state'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['order'] = this.order;
    data['state'] = this.state;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class QuoteReference {
  num id;
  String name;

  QuoteReference({this.id, this.name});

  QuoteReference.fromJson(Map<String, dynamic> json) {
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

class Photos {
  String photoId;

  Photos({this.photoId});

  Photos.fromJson(Map<String, dynamic> json) {
    photoId = json['photo_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo_id'] = this.photoId;
    return data;
  }
}

class Lines {
  num workchangeId;
  String name;
  num quantity;
  num priceHt;
  num sort;
  String comment;

  Lines(
      {this.workchangeId,
      this.name,
      this.quantity,
      this.priceHt,
      this.sort,
      this.comment});

  Lines.fromJson(Map<String, dynamic> json) {
    workchangeId = json['workchange_id'];
    name = json['name'];
    quantity = json['quantity'];
    priceHt = json['price_ht'];
    sort = json['sort'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workchange_id'] = this.workchangeId;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price_ht'] = this.priceHt;
    data['sort'] = this.sort;
    data['comment'] = this.comment;
    return data;
  }
}

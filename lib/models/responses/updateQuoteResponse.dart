class UpdateQuoteResponse {
  QuoteData quoteData;
  List<Null> errors;

  UpdateQuoteResponse({this.quoteData, this.errors});

  UpdateQuoteResponse.fromJson(Map<String, dynamic> json) {
    quoteData = json['quote-data'] != null
        ? new QuoteData.fromJson(json['quote-data'])
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
      data['quote-data'] = this.quoteData.toJson();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuoteData {
  Quote quote;

  QuoteData({this.quote});

  QuoteData.fromJson(Map<String, dynamic> json) {
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quote != null) {
      data['quote'] = this.quote.toJson();
    }
    return data;
  }
}

class Quote {
  num id;
  num discount;
  num franchise;
  num advance;
  String vat;
  num totalHt;
  num vatAmount;
  num totalTtc;

  Quote(
      {this.id,
      this.discount,
      this.franchise,
      this.advance,
      this.vat,
      this.totalHt,
      this.vatAmount,
      this.totalTtc});

  Quote.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discount = json['discount'];
    franchise = json['franchise'];
    advance = json['advance'];
    vat = json['vat'];
    totalHt = json['total_ht'];
    vatAmount = json['vat_amount'];
    totalTtc = json['total_ttc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount'] = this.discount;
    data['franchise'] = this.franchise;
    data['advance'] = this.advance;
    data['vat'] = this.vat;
    data['total_ht'] = this.totalHt;
    data['vat_amount'] = this.vatAmount;
    data['total_ttc'] = this.totalTtc;
    return data;
  }
}

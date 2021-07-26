class GetDesignationsNameResponse {
  List<ListQuoteReference> listQuoteReference;
  List<Null> errors;

  GetDesignationsNameResponse({this.listQuoteReference, this.errors});

  GetDesignationsNameResponse.fromJson(Map<String, dynamic> json) {
    if (json['list-quote-reference'] != null) {
      listQuoteReference = new List<ListQuoteReference>();
      json['list-quote-reference'].forEach((v) {
        listQuoteReference.add(new ListQuoteReference.fromJson(v));
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
    if (this.listQuoteReference != null) {
      data['list-quote-reference'] =
          this.listQuoteReference.map((v) => v.toJson()).toList();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListQuoteReference {
  num id;
  String designation;

  ListQuoteReference({this.id, this.designation});

  ListQuoteReference.fromJson(Map<String, dynamic> json) {
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

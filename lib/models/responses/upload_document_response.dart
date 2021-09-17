class UploadDocumentResponse {
  bool documentUploaded;
  Document document;

  //List<Null> errors;

  UploadDocumentResponse({this.documentUploaded, this.document});

  UploadDocumentResponse.fromJson(Map<String, dynamic> json) {
    documentUploaded = json['documentUploaded'];
    document = json['document'] != null
        ? new Document.fromJson(json['document'])
        : null;
    /*if (json['errors'] != null) {
      /*errors = new List<Null>();
      json['errors'].forEach((v) {
        //errors.add(new Null.fromJson(v));
      });*/
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentUploaded'] = this.documentUploaded;
    if (this.document != null) {
      data['document'] = this.document.toJson();
    }
    /*if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class Document {
  String uuid;
  String name;
  String type;
  String url;

  Document({this.uuid, this.name, this.type, this.url});

  Document.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}

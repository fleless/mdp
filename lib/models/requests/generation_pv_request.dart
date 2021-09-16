class GenerationPVFinTravauxRequest {
  num orderIdentifier;
  String documentType;
  Dataa data;

  GenerationPVFinTravauxRequest(
      {this.orderIdentifier, this.documentType, this.data});

  GenerationPVFinTravauxRequest.fromJson(Map<String, dynamic> json) {
    orderIdentifier = json['orderIdentifier'];
    documentType = json['documentType'];
    data = json['data'] != null ? new Dataa.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderIdentifier'] = this.orderIdentifier;
    data['documentType'] = this.documentType;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Dataa {
  String comments;
  String noProblems;
  String problems;
  String subcontractorSignature;
  String clientSignature;

  Dataa(
      {this.comments,
      this.noProblems,
      this.problems,
      this.subcontractorSignature,
      this.clientSignature});

  Dataa.fromJson(Map<String, dynamic> json) {
    comments = json['comments'];
    noProblems = json['no_problems'];
    problems = json['problems'];
    subcontractorSignature = json['subcontractor_signature'];
    clientSignature = json['client_signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comments'] = this.comments;
    data['no_problems'] = this.noProblems;
    data['problems'] = this.problems;
    data['subcontractor_signature'] = this.subcontractorSignature;
    data['client_signature'] = this.clientSignature;
    return data;
  }
}

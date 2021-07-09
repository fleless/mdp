class AddAppointmentResponse {
  VisitData visitData;
  List<Null> errors;

  AddAppointmentResponse({this.visitData, this.errors});

  AddAppointmentResponse.fromJson(Map<String, dynamic> json) {
    visitData = json['visit-data'] != null
        ? new VisitData.fromJson(json['visit-data'])
        : null;
    if (json['errors'] != null) {
      //errors = new List<Null>();
      json['errors'].forEach((v) {
        //errors.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.visitData != null) {
      data['visit-data'] = this.visitData.toJson();
    }
    if (this.errors != null) {
      //data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VisitData {
  int id;
  String title;
  String startDate;
  String endDate;

  VisitData({this.id, this.title, this.startDate, this.endDate});

  VisitData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}

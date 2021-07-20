class ResultMessageResponse {
  String result;
  String message;

  ResultMessageResponse({this.result, this.message});

  ResultMessageResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    return data;
  }
}

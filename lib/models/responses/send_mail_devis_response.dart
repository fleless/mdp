class SendMailDevisResponse {
  SendEmailData sendEmailData;

  SendMailDevisResponse({this.sendEmailData});

  SendMailDevisResponse.fromJson(Map<String, dynamic> json) {
    sendEmailData = json['send_email_data'] != null
        ? new SendEmailData.fromJson(json['send_email_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sendEmailData != null) {
      data['send_email_data'] = this.sendEmailData.toJson();
    }
    return data;
  }
}

class SendEmailData {
  bool mailSent;

  SendEmailData({this.mailSent});

  SendEmailData.fromJson(Map<String, dynamic> json) {
    mailSent = json['mail_sent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mail_sent'] = this.mailSent;
    return data;
  }
}

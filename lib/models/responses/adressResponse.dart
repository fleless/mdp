class AdressResponse {
  String nom;
  String code;

  AdressResponse({this.nom, this.code});

  AdressResponse.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['code'] = this.code;
    return data;
  }
}

class SpecialitesModel {
  int? idSpecialite;
  String? libelle;

  SpecialitesModel({this.idSpecialite, this.libelle});

  SpecialitesModel.fromJson(Map<String, dynamic> json) {
    idSpecialite = json['id_specialite'];
    libelle = json['libelle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_specialite'] = this.idSpecialite;
    data['libelle'] = this.libelle;
    return data;
  }
}

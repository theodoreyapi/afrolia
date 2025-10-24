class SpecialiteModel {
  int? idSpecialite;
  String? libelle;
  int? isAssocie;

  SpecialiteModel({this.idSpecialite, this.libelle, this.isAssocie});

  SpecialiteModel.fromJson(Map<String, dynamic> json) {
    idSpecialite = json['id_specialite'];
    libelle = json['libelle'];
    isAssocie = json['is_associe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_specialite'] = idSpecialite;
    data['libelle'] = libelle;
    data['is_associe'] = isAssocie;
    return data;
  }

  // ✅ Ajout pour comparaison correcte dans contains()
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecialiteModel &&
          runtimeType == other.runtimeType &&
          idSpecialite == other.idSpecialite;

  @override
  int get hashCode => idSpecialite.hashCode;
}

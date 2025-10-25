class ServiceModel {
  int? idService;
  int? prix;
  int? minute;
  String? description;
  int? commission;
  int? idUtilisateur;
  int? idSpeciale;
  String? createdAt;
  String? updatedAt;
  Specialite? specialite;

  ServiceModel({
    this.idService,
    this.prix,
    this.minute,
    this.description,
    this.commission,
    this.idUtilisateur,
    this.idSpeciale,
    this.specialite,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    idService = json['id_service'];
    prix = json['prix'];
    minute = json['minute'];
    description = json['description'];
    commission = json['commission'];
    idUtilisateur = json['id_utilisateur'];
    idSpeciale = json['id_speciale'];
    specialite = json['specialite'] != null
        ? new Specialite.fromJson(json['specialite'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_service'] = this.idService;
    data['prix'] = this.prix;
    data['minute'] = this.minute;
    data['description'] = this.description;
    data['commission'] = this.commission;
    data['id_utilisateur'] = this.idUtilisateur;
    data['id_speciale'] = this.idSpeciale;
    if (this.specialite != null) {
      data['specialite'] = this.specialite!.toJson();
    }
    return data;
  }
}

class Specialite {
  int? idSpecialite;
  String? libelle;

  Specialite({this.idSpecialite, this.libelle});

  Specialite.fromJson(Map<String, dynamic> json) {
    idSpecialite = json['id_specialite'];
    libelle = json['libelle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_specialite'] = this.idSpecialite;
    data['libelle'] = this.libelle;
    return data;
  }
}

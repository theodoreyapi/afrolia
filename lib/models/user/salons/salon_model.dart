class SalonModel {
  int? id;
  String? photo;
  String? nomComplet;
  String? commune;
  int? experience;
  int? note;
  int? nombreAvis;
  List<String>? specialites;
  String? prixRange;
  String? statut;

  SalonModel(
      {this.id,
        this.photo,
        this.nomComplet,
        this.commune,
        this.experience,
        this.note,
        this.nombreAvis,
        this.specialites,
        this.prixRange,
        this.statut});

  SalonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    nomComplet = json['nom_complet'];
    commune = json['commune'];
    experience = json['experience'];
    note = json['note'];
    nombreAvis = json['nombre_avis'];
    specialites = json['specialites'].cast<String>();
    prixRange = json['prix_range'];
    statut = json['statut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['nom_complet'] = this.nomComplet;
    data['commune'] = this.commune;
    data['experience'] = this.experience;
    data['note'] = this.note;
    data['nombre_avis'] = this.nombreAvis;
    data['specialites'] = this.specialites;
    data['prix_range'] = this.prixRange;
    data['statut'] = this.statut;
    return data;
  }
}

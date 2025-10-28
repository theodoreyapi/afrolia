class JourHeureModel {
  int? idJour;
  String? jour;
  List<Heures>? heures;

  JourHeureModel({this.idJour, this.jour, this.heures});

  JourHeureModel.fromJson(Map<String, dynamic> json) {
    idJour = json['id_jour'];
    jour = json['jour'];
    if (json['heures'] != null) {
      heures = <Heures>[];
      json['heures'].forEach((v) {
        heures!.add(Heures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_jour'] = idJour;
    data['jour'] = jour;
    if (heures != null) {
      data['heures'] = heures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Heures {
  int? idHeure;
  String? libelle;

  Heures({this.idHeure, this.libelle});

  Heures.fromJson(Map<String, dynamic> json) {
    idHeure = json['id_heure'];
    libelle = json['libelle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_heure'] = idHeure;
    data['libelle'] = libelle;
    return data;
  }
}
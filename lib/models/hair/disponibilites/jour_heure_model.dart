class JourHeureModel {
  String? jour;
  List<Heures>? heures;

  JourHeureModel({this.jour, this.heures});

  JourHeureModel.fromJson(Map<String, dynamic> json) {
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

class LaguageModel {
  int? idLangue;
  String? libelle;
  int? isAssocie;

  LaguageModel({this.idLangue, this.libelle, this.isAssocie});

  LaguageModel.fromJson(Map<String, dynamic> json) {
    idLangue = json['id_langue'];
    libelle = json['libelle'];
    isAssocie = json['is_associe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_langue'] = idLangue;
    data['libelle'] = libelle;
    data['is_associe'] = isAssocie;
    return data;
  }

  // ✅ Ajout pour comparaison correcte dans contains()
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LaguageModel &&
              runtimeType == other.runtimeType &&
              LaguageModel == other.idLangue;

  @override
  int get hashCode => idLangue.hashCode;
}

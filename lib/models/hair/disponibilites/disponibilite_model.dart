class DisponibiliteModel {
  String? jour;
  List<String>? heures;

  DisponibiliteModel({this.jour, this.heures});

  DisponibiliteModel.fromJson(Map<String, dynamic> json) {
    jour = json['jour'];
    heures = json['heures'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jour'] = jour;
    data['heures'] = heures;
    return data;
  }
}

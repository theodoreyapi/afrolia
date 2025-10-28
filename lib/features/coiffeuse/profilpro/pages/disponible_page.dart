import 'dart:convert';
import 'dart:io';

import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:afrolia/core/utils/utils.dart';
import 'package:afrolia/models/hair/disponibilites/disponibilite_model.dart';
import 'package:afrolia/models/hair/disponibilites/jour_heure_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class DisponiblePage extends StatefulWidget {
  const DisponiblePage({super.key});

  @override
  State<DisponiblePage> createState() => _DisponiblePageState();
}

class _DisponiblePageState extends State<DisponiblePage> {
  List<JourHeureModel> joursHeures = [];
  List<DisponibiliteModel> disponibilites = [];
  Map<String, List<Heures>> selectedByDay = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final jours = await fetchJoursHeures();
    final dispo = await fetchDisponibilites();

    // Initialisation des jours
    for (var jour in jours) {
      selectedByDay[jour.jour!] = [];
    }

    // Pré-sélectionner les heures existantes
    for (var dispoJour in dispo) {
      final jour = dispoJour.jour;
      final heures = dispoJour.heures ?? [];

      // Trouver les Heures correspondantes dans joursHeures pour retrouver leurs IDs
      final jourHeure = jours.firstWhere(
        (j) => j.jour == jour,
        orElse: () => JourHeureModel(jour: jour, heures: []),
      );

      for (var heureLabel in heures) {
        final heureObj = jourHeure.heures?.firstWhere(
          (h) => h.libelle == heureLabel,
          orElse: () => Heures(),
        );

        if (heureObj != null && heureObj.idHeure != null) {
          selectedByDay[jour]!.add(heureObj);
        }
      }
    }

    setState(() {
      joursHeures = jours;
      disponibilites = dispo;
      isLoading = false;
    });
  }

  Future<List<JourHeureModel>> fetchJoursHeures() async {
    final response = await http.get(Uri.parse(ApiUrls.getListJoursHeures));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => JourHeureModel.fromJson(e)).toList();
    } else {
      throw Exception("Erreur de chargement des jours et heures");
    }
  }

  Future<List<DisponibiliteModel>> fetchDisponibilites() async {
    final response = await http.get(
      Uri.parse(
        "${ApiUrls.getListDisponibility}${SharedPreferencesHelper().getString('identifiant')}",
      ),
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => DisponibiliteModel.fromJson(e)).toList();
    } else {
      throw Exception("Erreur de chargement des disponibilités");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  FloatingActionButton.small(
                    backgroundColor: appColorWhite,
                    elevation: 0,
                    shape: CircleBorder(),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Icon(Icons.arrow_back, color: appColorText),
                  ),
                  Text(
                    "Mes disponibilites",
                    style: TextStyle(
                      color: appColorText,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Gap(2.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      planning(context),
                      Gap(2.h),
                      Container(
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.w),
                          border: Border.all(color: appColorBorder, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.emoji_objects_outlined,
                              color: appColorTextThree,
                            ),
                            Gap(2.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Conseil",
                                    style: TextStyle(
                                      color: appColorText,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Plus vous avez de créneaux disponibles, "
                                    "plus vous avez de chances d'avoir des "
                                    "réservations. Vous pouvez toujours "
                                    "bloquer des créneaux ponctuellement.",
                                    style: TextStyle(
                                      color: appColorTextSecond,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(6.w),
        child: SubmitButton(
          AppConstants.btnUpdate,
          onPressed: updateDisponibilite,
        ),
      ),
    );
  }

  List<Map<String, dynamic>> buildDisponibiliteList() {
    List<Map<String, dynamic>> list = [];

    for (var jourHeure in joursHeures) {
      final jour = jourHeure.jour!;
      final idJour = jourHeure.idJour;
      final heures = selectedByDay[jour] ?? [];

      for (var h in heures) {
        list.add({"id_day": idJour, "id_time": h.idHeure});
      }
    }

    return list;
  }

  Future<void> updateDisponibilite() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text('Mise à jour en cours...')),
            ],
          ),
        );
      },
    );

    final disponibilites = buildDisponibiliteList();

    final body = {
      "id_utilisateur": SharedPreferencesHelper().getString('identifiant'),
      "disponibilites": disponibilites,
    };

    final response = await http.post(
      Uri.parse(ApiUrls.postSaveDisponibility),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        SnackbarHelper.showSuccess(
          context,
          "Disponibilités mises à jour avec succès.",
        );
      } else {
        print("Erreur: ${data['message']}");
        SnackbarHelper.showError(context, data['message']);
      }
    } else {
      print("Erreur API: ${response.body}");
    }
  }

  Widget planning(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: joursHeures.map((jourHeure) {
        final jour = jourHeure.jour!;
        final heures = jourHeure.heures ?? [];

        return Container(
          margin: EdgeInsets.only(bottom: 2.h),
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: appColorWhite,
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jour,
                style: TextStyle(
                  color: appColorText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              Gap(2.h),

              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: heures.length,
                itemBuilder: (context, index) {
                  final horaire = heures[index];
                  final isSelected = selectedByDay[jour]!.any(
                    (h) => h.idHeure == horaire.idHeure,
                  );

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedByDay[jour]!.removeWhere(
                            (h) => h.idHeure == horaire.idHeure,
                          );
                        } else {
                          selectedByDay[jour]!.add(horaire);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? appColor : appColorBorder,
                        border: Border.all(
                          color: isSelected ? appColor : appColorBorder,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: Center(
                        child: Text(
                          horaire.libelle ?? '',
                          style: TextStyle(
                            color: isSelected
                                ? appColorWhite
                                : appColorTextSecond,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

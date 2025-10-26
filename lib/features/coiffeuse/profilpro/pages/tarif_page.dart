import 'dart:convert';

import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/utils/utils.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:afrolia/features/coiffeuse/profilpro/profilepro.dart';
import 'package:afrolia/models/hair/services/service_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class TarifPage extends StatefulWidget {
  const TarifPage({super.key});

  @override
  State<TarifPage> createState() => _TarifPageState();
}

class _TarifPageState extends State<TarifPage> {
  final formatterNumber = NumberFormat('#,###', 'fr_FR');

  List<ServiceModel> allMedicaments = [];
  bool isLoading = false;
  late Future<List<ServiceModel>> _futureMedicaments;

  @override
  void initState() {
    super.initState();
    _futureMedicaments = fetchMedicaments();
  }

  void _refreshData() {
    setState(() {
      _futureMedicaments = fetchMedicaments();
    });
  }

  Future<List<ServiceModel>> fetchMedicaments() async {
    final http.Response response = await http.get(
      Uri.parse(
        "${ApiUrls.getListServices}${SharedPreferencesHelper().getString('identifiant')}",
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(
        utf8.decode(response.bodyBytes),
      );

      final List<dynamic> contentList = jsonResponse['data'];

      List<ServiceModel> medicaments = contentList
          .map((item) => ServiceModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return medicaments;
    } else {
      throw Exception("Une erreur s'est produite");
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
                  Spacer(),
                  Text(
                    "Mes Services & Tarifs",
                    style: TextStyle(
                      color: appColorText,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton.small(
                    shape: CircleBorder(),
                    elevation: 0,
                    heroTag: 'Refesh',
                    tooltip: 'Actualiser la liste',
                    backgroundColor: appColorWhite,
                    onPressed: _refreshData,
                    child: Icon(Icons.refresh, color: appColorText),
                  ),
                ],
              ),
              Gap(4.h),
              Expanded(
                child: FutureBuilder<List<ServiceModel>>(
                  future: _futureMedicaments,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Impossible d'avoir la liste de vos services. "
                          "Verifiez votre internet. Si le probleme "
                          "persiste veuillez contactez AFROLIA",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      allMedicaments = snapshot.data!;

                      if (allMedicaments.isEmpty) {
                        return Center(child: Text("Pas de service disponible"));
                      }

                      return ListView.builder(
                        itemCount: allMedicaments.length,
                        itemBuilder: (context, index) {
                          final medocs = allMedicaments[index];
                          final total = medocs.commission! + medocs.prix!;
                          return Container(
                            padding: EdgeInsets.all(3.w),
                            margin: EdgeInsets.only(bottom: 2.w),
                            decoration: BoxDecoration(
                              color: appColorWhite,
                              borderRadius: BorderRadius.circular(3.w),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "#${index + 1} ${medocs.specialite!.libelle}",
                                      style: TextStyle(
                                        color: appColorText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Spacer(),
                                    FloatingActionButton(
                                      heroTag: 'Delete$index',
                                      mini: true,
                                      elevation: 0,
                                      shape: CircleBorder(),
                                      backgroundColor: Colors.blue.withValues(
                                        alpha: .2,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          showBarModalBottomSheet(
                                            isDismissible: false,
                                            enableDrag: false,
                                            expand: true,
                                            topControl: Align(
                                              alignment: Alignment.centerLeft,
                                              child: FloatingActionButton.small(
                                                heroTag: "close$index",
                                                backgroundColor: appColorWhite,
                                                shape: const CircleBorder(),
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Icon(
                                                  Icons.close,
                                                  color: appColorBlack,
                                                ),
                                              ),
                                            ),
                                            context: context,
                                            builder: (context) =>
                                                EditServicePage(
                                                  service: medocs,
                                                ),
                                          );
                                        });
                                      },
                                      child: Icon(
                                        Icons.edit_outlined,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    FloatingActionButton(
                                      heroTag: 'Edit$index',
                                      mini: true,
                                      elevation: 0,
                                      shape: CircleBorder(),
                                      backgroundColor: Colors.red.withValues(
                                        alpha: .2,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                    top: Radius.circular(25),
                                                  ),
                                            ),
                                            builder: (BuildContext context) {
                                              return Container(
                                                padding: EdgeInsets.all(5.w),
                                                decoration: BoxDecoration(
                                                  color: appColorWhite,
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                        top: Radius.circular(
                                                          25,
                                                        ),
                                                      ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withValues(
                                                            alpha: 0.1,
                                                          ),
                                                      blurRadius: 10,
                                                      offset: const Offset(
                                                        0,
                                                        -3,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    // petite barre au-dessus pour esthétique
                                                    Container(
                                                      width: 40,
                                                      height: 5,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              3,
                                                            ),
                                                      ),
                                                    ),
                                                    Gap(3.h),

                                                    // Icône expressive
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.red
                                                            .withValues(
                                                              alpha: 0.1,
                                                            ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      padding: EdgeInsets.all(
                                                        3.w,
                                                      ),
                                                      child: const Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.red,
                                                        size: 40,
                                                      ),
                                                    ),

                                                    Gap(2.h),

                                                    // Titre
                                                    Text(
                                                      "Supprimer ce service ?",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: appColorBlack,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),

                                                    Gap(1.h),

                                                    // Sous-texte explicatif
                                                    Text(
                                                      "Cette action supprimera "
                                                      "définitivement le service "
                                                      "n°${index + 1} ${medocs.specialite!.libelle} "
                                                      "et il ne sera plus accessible aux utilisateurs.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontSize: 14.sp,
                                                        height: 1.5,
                                                      ),
                                                    ),

                                                    Gap(3.h),

                                                    // Bloc d'information douce
                                                    Container(
                                                      padding: EdgeInsets.all(
                                                        3.w,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: appColor
                                                            .withValues(
                                                              alpha: .08,
                                                            ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              3.w,
                                                            ),
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.info_outline,
                                                            color: appColor,
                                                            size: 22,
                                                          ),
                                                          Gap(2.w),
                                                          Expanded(
                                                            child: Text(
                                                              "Assurez-vous de vouloir poursuivre cette suppression. "
                                                              "Cette action est irréversible.",
                                                              style: TextStyle(
                                                                color: appColor,
                                                                fontSize: 14.sp,
                                                                height: 1.4,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    Gap(3.h),

                                                    // Boutons d'action
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: CancelButton(
                                                            "Annuler",
                                                            height: 10.w,
                                                            fontSize: 15.sp,
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                  context,
                                                                ),
                                                          ),
                                                        ),
                                                        Gap(3.w),
                                                        Expanded(
                                                          child: SubmitButton(
                                                            "Supprimer",
                                                            height: 10.w,
                                                            fontSize: 15.sp,
                                                            couleur: Colors.red,
                                                            onPressed: () async {
                                                              await deleteService(
                                                                medocs
                                                                    .idService!,
                                                              );
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    Gap(1.h),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        });
                                      },
                                      child: Icon(
                                        Icons.restore_from_trash_outlined,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(2.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Prix"),
                                          Text(
                                            "${formatterNumber.format(medocs.prix!)} FCFA",
                                            style: TextStyle(
                                              color: appColorText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gap(1.w),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text("Durée (min)"),
                                          Text(
                                            "${medocs.minute}",
                                            style: TextStyle(
                                              color: appColorTextThree,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(1.h),
                                Text("Description du service"),
                                Text(
                                  medocs.description!,
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Gap(2.h),
                                Container(
                                  padding: EdgeInsets.all(3.w),
                                  decoration: BoxDecoration(
                                    color: appColorFond,
                                    borderRadius: BorderRadius.circular(3.w),
                                    border: Border.all(
                                      width: 2,
                                      color: appColorBorder,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Prix client final (commission 15%)",
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${formatterNumber.format(total)} FCFA",
                                        style: TextStyle(
                                          color: appColorText,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: Text("Aucune donnée disponible"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(7.w),
        child: SubmitButton(
          AppConstants.btnCreateService,
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServicePage()),
            );
          },
        ),
      ),
    );
  }

  Future<void> deleteService(int idService) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text('Suppression en cours...')),
            ],
          ),
        );
      },
    );

    final http.Response response = await http.delete(
      Uri.parse("${ApiUrls.deleteDeleteService}$idService"),
      headers: {'Content-Type': 'application/json'},
    );

    Navigator.pop(context);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      SnackbarHelper.showSuccess(context, "Service supprimé avec succès");
      setState(() {
        _refreshData();
      });
    } else {
      SnackbarHelper.showError(
        context,
        "Impossible de supprimer le service. Veuillez réessayer!",
      );
      throw Exception("Une erreur s'est produite");
    }
  }
}

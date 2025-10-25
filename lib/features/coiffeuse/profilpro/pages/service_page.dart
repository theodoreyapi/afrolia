import 'dart:convert';

import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/models/hair/specialites/asso_specialite_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../../../core/themes/themes.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/buttons/cancel_button_icon.dart';
import '../../../../core/widgets/buttons/submit_button.dart';
import '../../../../core/widgets/inputs/input_text.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class ServiceForm {
  final GlobalKey<FormState> _formKeyInfo = GlobalKey<FormState>();
  final serviceController = TextEditingController();
  final prixController = TextEditingController();
  final dureController = TextEditingController();
  final descriptionController = TextEditingController();
  int? selectedSpecialiteId;
}

class _ServicePageState extends State<ServicePage> {
  final List<ServiceForm> servicesForms = [ServiceForm()];

  List<SpecialiteModel> allSpecialites = [];
  List<SpecialiteModel> specialites = [];
  bool isLoading = false;
  late Future<List<SpecialiteModel>> _futureSpecialites;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    _loadSpecialites();
  }

  Future<void> _loadSpecialites() async {
    try {
      final data = await fetchSpecialites(); // ta fonction API
      setState(() {
        specialites = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print("Erreur lors du chargement des spécialités: $e");
    }
  }

  @override
  void dispose() {
    // Libérer les contrôleurs
    for (var form in servicesForms) {
      form.serviceController.dispose();
      form.prixController.dispose();
      form.dureController.dispose();
      form.descriptionController.dispose();
    }
    super.dispose();
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
                    "Ajout de Services & Tarifs",
                    style: TextStyle(
                      color: appColorText,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Gap(4.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(servicesForms.length, (index) {
                        return informations(context, index);
                      }),
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
                            Icon(Icons.info_outline, color: appColorTextThree),
                            Gap(2.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Commission Afrolia",
                                    style: TextStyle(
                                      color: appColorText,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Une commission de 15% est appliquée sur "
                                    "chaque réservation. Le prix affiché "
                                    "aux clients inclut cette commission.",
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
        padding: EdgeInsets.all(4.w),
        child: Row(
          children: [
            Expanded(
              child: CancelButtonIcon(
                fontSize: 14.sp,
                icone: Icon(Icons.add, color: appColorText),
                AppConstants.btnAdd,
                onPressed: () async {
                  setState(() {
                    servicesForms.add(ServiceForm());
                  });
                },
              ),
            ),
            Gap(2.w),
            Expanded(
              flex: 2,
              child: SubmitButton(
                AppConstants.btnUpdate,
                onPressed: () async {
                  bool allValid = true;

                  // Vérifie que tous les formulaires sont valides
                  for (var form in servicesForms) {
                    if (!(form._formKeyInfo.currentState?.validate() ??
                        false)) {
                      allValid = false;
                    }
                  }

                  if (allValid) {
                    await addSpecialites();
                  } else {
                    SnackbarHelper.showError(context, "Vérifiez les champs");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<SpecialiteModel>> fetchSpecialites() async {
    final http.Response response = await http.get(
      Uri.parse(
        "${ApiUrls.getListAssoSpecialiste}${SharedPreferencesHelper().getString('identifiant')}",
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(
        utf8.decode(response.bodyBytes),
      );

      final List<dynamic> contentList = jsonResponse['data'];

      List<SpecialiteModel> specialites = contentList
          .map((item) => SpecialiteModel.fromJson(item as Map<String, dynamic>))
          .toList();

      // ✅ Filtrage : ne garder que ceux dont isAssocie == 1
      specialites = specialites.where((s) => s.isAssocie == 1).toList();

      return specialites;
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  Widget informations(BuildContext context, int index) {
    final serviceForm = servicesForms[index];

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: appColorWhite,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Form(
        key: serviceForm._formKeyInfo,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Titre + bouton supprimer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Service #${index + 1}",
                  style: TextStyle(
                    color: appColorText,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                if (servicesForms.length > 1) // éviter de supprimer le dernier
                  FloatingActionButton(
                    heroTag: 'delete_button_$index',
                    mini: true,
                    elevation: 0,
                    shape: CircleBorder(),
                    backgroundColor: Colors.red.withValues(alpha: .2),
                    onPressed: () {
                      setState(() {
                        servicesForms.removeAt(index);
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

            /// Champs
            isLoading
                ? Center(child: CircularProgressIndicator())
                : DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: appColorFond,
                      hintText: "Sélectionnez une spécialité*",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.w),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    value: serviceForm.selectedSpecialiteId,
                    validator: (value) => value == null
                        ? "Veuillez choisir une spécialité"
                        : null,
                    items: specialites
                        .map(
                          (sp) => DropdownMenuItem<int>(
                            value: sp.idSpecialite,
                            child: Text(sp.libelle ?? ""),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        serviceForm.selectedSpecialiteId = value;
                        serviceForm.serviceController.text = specialites
                            .firstWhere((sp) => sp.idSpecialite == value)
                            .libelle!;
                      });
                    },
                  ),
            Gap(1.h),

            Row(
              children: [
                Expanded(
                  child: InputText(
                    hintText: "Prix*",
                    keyboardType: TextInputType.number,
                    controller: serviceForm.prixController,
                    colorFille: appColorFond,
                    validatorMessage: "Veuillez saisir le prix",
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                Gap(1.w),
                Expanded(
                  child: InputText(
                    hintText: "Durée (min)",
                    keyboardType: TextInputType.number,
                    controller: serviceForm.dureController,
                    colorFille: appColorFond,
                    validatorMessage: "Veuillez saisir la durée",
                  ),
                ),
              ],
            ),
            Gap(1.h),

            InputText(
              hintText: "Description du service",
              keyboardType: TextInputType.text,
              controller: serviceForm.descriptionController,
              colorFille: appColorFond,
              maxLines: 3,
            ),
            Gap(2.h),

            /// Exemple de prix calculé
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: appColorFond,
                borderRadius: BorderRadius.circular(3.w),
                border: Border.all(width: 2, color: appColorBorder),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    "${_prixClientFinal(serviceForm)} FCFA",
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
      ),
    );
  }

  String _prixClientFinal(ServiceForm form) {
    if (form.prixController.text.isEmpty) return "0";
    final prix = double.tryParse(form.prixController.text) ?? 0;
    final prixFinal = prix + (prix * 0.15); // Commission 15%
    return prixFinal.toStringAsFixed(0);
  }

  Future<void> addSpecialites() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text('Ajout de service...')),
            ],
          ),
        );
      },
    );

    final identifiant = SharedPreferencesHelper().getString('identifiant');

    // 🔹 Vérification préalable
    for (var form in servicesForms) {
      if (form.selectedSpecialiteId == null) {
        Navigator.pop(context);
        SnackbarHelper.showError(context, "Veuillez sélectionner une spécialité pour chaque service.");
        return;
      }
    }

    // 🔹 Création de la liste des services
    List<Map<String, dynamic>> servicesData = servicesForms.map((form) {
      final prix = double.tryParse(form.prixController.text) ?? 0.0;
      final duree = int.tryParse(form.dureController.text) ?? 0;
      final description = form.descriptionController.text;
      final idSpecialite = form.selectedSpecialiteId;
      final commission = prix * 0.15; // 15% de commission

      return {
        "id_utilisateur": identifiant,
        "prix": prix,
        "minute": duree,
        "description": description,
        "commission": commission,
        "id_speciale": idSpecialite, // ✅ clé correcte
      };
    }).toList();

    final body = jsonEncode({'services': servicesData});

    print("📤 Body envoyé : $body");

    try {
      final response = await http.post(
        Uri.parse(ApiUrls.postSaveService),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      Navigator.pop(context);

      print("Status: ${response.statusCode}");
      print("Response: ${response.body}");

      final Map<String, dynamic> responseData =
      jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 201) {
        SnackbarHelper.showSuccess(context, "Vos services ont été ajoutés avec succès !");
      } else if (response.statusCode == 422) {
        final message = responseData['message'];
        if (message is List && message.isNotEmpty) {
          SnackbarHelper.showError(context, message.first);
        } else if (message is String) {
          SnackbarHelper.showError(context, message);
        } else {
          SnackbarHelper.showError(context, "Une erreur est survenue.");
        }
      } else {
        SnackbarHelper.showError(
          context,
          "Impossible d'ajouter le service. Veuillez réessayer!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      SnackbarHelper.showError(context, "Erreur réseau : $e");
    }
  }
}

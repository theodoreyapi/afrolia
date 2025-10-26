import 'dart:convert';

import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/utils/utils.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:afrolia/models/hair/services/service_model.dart';
import 'package:afrolia/models/hair/specialites/asso_specialite_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class EditServicePage extends StatefulWidget {
  ServiceModel? service;

  EditServicePage({super.key, this.service});

  @override
  State<EditServicePage> createState() => _EditServicePageState();
}

class _EditServicePageState extends State<EditServicePage> {
  final _formKeyInfo = GlobalKey<FormState>();

  int? selectedSpecialiteId;
  List<SpecialiteModel> specialites = [];
  bool isLoading = false;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  var serviceController = TextEditingController();
  var prixController = TextEditingController();
  var descriptionController = TextEditingController();
  var dureController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    serviceController.text = widget.service!.specialite!.libelle!;
    prixController.text = widget.service!.prix!.toString();
    descriptionController.text = widget.service!.description!;
    dureController.text = widget.service!.minute!.toString();

    selectedSpecialiteId = widget.service!.specialite!.idSpecialite!;

    _loadSpecialites();
  }

  Future<void> _loadSpecialites() async {
    try {
      final data = await fetchSpecialites();
      setState(() {
        specialites = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print("Erreur lors du chargement des spécialités: $e");
    }
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

      specialites = specialites.where((s) => s.isAssocie == 1).toList();

      return specialites;
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appColorWhite,
        title: Text(
          "Modification",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(2.h),
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColorWhite,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Form(
                    key: _formKeyInfo,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.service!.specialite!.libelle!,
                              style: TextStyle(
                                color: appColorText,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                        Gap(2.h),
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
                                value: selectedSpecialiteId,
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
                                    selectedSpecialiteId = value;
                                    serviceController.text = specialites
                                        .firstWhere(
                                          (sp) => sp.idSpecialite == value,
                                        )
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
                                controller: prixController,
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
                                controller: dureController,
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
                          controller: descriptionController,
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
                                "${_prixClientFinal()} FCFA",
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
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(6.w),
        child: SubmitButton(
          AppConstants.btnUpdate,
          onPressed: () async {
            bool allValid = true;

            if (!(_formKeyInfo.currentState?.validate() ?? false)) {
              allValid = false;
            }

            if (allValid) {
              await editSpecialites();
            } else {
              SnackbarHelper.showError(context, "Vérifiez les champs");
            }
          },
        ),
      ),
    );
  }

  String _prixClientFinal() {
    if (prixController.text.isEmpty) return "0";
    final prix = double.tryParse(prixController.text) ?? 0;
    final prixFinal = prix + (prix * 0.15); // Commission 15%
    return prixFinal.toStringAsFixed(0);
  }

  Future<void> editSpecialites() async {
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

    final identifiant = SharedPreferencesHelper().getString('identifiant');

    // 🔹 Vérification préalable
    if (selectedSpecialiteId == null) {
      Navigator.pop(context);
      SnackbarHelper.showError(
        context,
        "Veuillez sélectionner une spécialité pour le service.",
      );
      return;
    }

    final prix = double.tryParse(prixController.text) ?? 0.0;

    final body = jsonEncode({
      "id_utilisateur": identifiant,
      "prix": prix,
      "minute": int.tryParse(dureController.text) ?? 0,
      "description": descriptionController.text,
      "commission": prix * 0.15,
      "id_speciale": selectedSpecialiteId,
    });

    print("📤 Body envoyé : $body");

    try {
      final response = await http.put(
        Uri.parse("${ApiUrls.putUpdateService}${widget.service!.idService}"),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      Navigator.pop(context);

      print("Status: ${response.statusCode}");
      print("Response: ${response.body}");

      final Map<String, dynamic> responseData = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        SnackbarHelper.showSuccess(
          context,
          "Votre service a été modifié avec succès !",
        );
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

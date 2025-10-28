import 'dart:convert';
import 'dart:io';

import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:afrolia/core/utils/utils.dart';
import 'package:afrolia/models/hair/language/asso_language_model.dart';
import 'package:afrolia/models/hair/specialites/asso_specialite_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

class InfoProPage extends StatefulWidget {
  const InfoProPage({super.key});

  @override
  State<InfoProPage> createState() => _InfoProPageState();
}

class _InfoProPageState extends State<InfoProPage> {
  final _formKeyInfo = GlobalKey<FormState>();
  final _formKeyPresentation = GlobalKey<FormState>();
  final _formKeySpecial = GlobalKey<FormState>();
  final _formKeyLanguage = GlobalKey<FormState>();
  bool _obscure = true;

  List<SpecialiteModel> allSpecialites = [];
  List<LaguageModel> allLanguages = [];
  bool isLoading = false;
  late Future<List<SpecialiteModel>> _futureSpecialites;
  late Future<List<LaguageModel>> _futureLanguages;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  late int _charCount = 0;

  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var name = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var commune = TextEditingController();
  var adresse = TextEditingController();
  var annee = TextEditingController();
  var present = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    present.addListener(() {
      setState(() {
        _charCount = present.text.length;
      });
    });

    commune.text = SharedPreferencesHelper().getString('commune')!;
    adresse.text = SharedPreferencesHelper().getString('adresse')!;
    annee.text = SharedPreferencesHelper().getInt('experience')!.toString();
    present.text = SharedPreferencesHelper().getString('presentation')!;
    email.text = SharedPreferencesHelper().getString('email')!;
    name.text = SharedPreferencesHelper().getString('nom')!;
    lastName.text = SharedPreferencesHelper().getString('prenom')!;

    _futureSpecialites = fetchSpecialites();
    _futureLanguages = fetchLanguages();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String phoneIndicator = "";
  String initialCountry = 'CI';
  PhoneNumber number = PhoneNumber(isoCode: 'CI');

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
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
                    "Modifier mon profil",
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
                      informations(context),
                      Gap(2.h),
                      presentation(context),
                      Gap(2.h),
                      specialites(context),
                      Gap(2.h),
                      languages(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<SpecialiteModel> selectedServices = [];
  List<LaguageModel> selectedLanguages = [];

  Widget informations(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: appColorWhite,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Form(
        key: _formKeyInfo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: appColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      image: _image != null
                          ? DecorationImage(
                              image: FileImage(_image!),
                              // image prise depuis la galerie
                              fit: BoxFit.cover,
                            )
                          : (SharedPreferencesHelper().getString('photo') !=
                                    null &&
                                SharedPreferencesHelper()
                                    .getString('photo')!
                                    .isNotEmpty)
                          ? DecorationImage(
                              image: NetworkImage(
                                SharedPreferencesHelper().getString('photo')!,
                              ), // image venant du serveur
                              fit: BoxFit.cover,
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child:
                        (_image == null &&
                            (SharedPreferencesHelper().getString('photo') ==
                                    null ||
                                SharedPreferencesHelper()
                                    .getString('photo')!
                                    .isEmpty))
                        ? Icon(
                            Icons.person,
                            size: 50,
                            color: appColor.withValues(alpha: 0.3),
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: -5,
                    right: -5,
                    child: CircleAvatar(
                      backgroundColor: appColor,
                      radius: 18,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.image, size: 18, color: appColorWhite),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(2.5.h),
            Text(
              "Informations personnelles",
              style: TextStyle(
                color: appColorText,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            Gap(2.h),
            InputText(
              hintText: "Nom*",
              keyboardType: TextInputType.text,
              controller: name,
              colorFille: appColorFond,
              validatorMessage: "Veuillez saisir votre nom",
            ),
            Gap(1.h),
            InputText(
              hintText: "Prénoms*",
              keyboardType: TextInputType.text,
              controller: lastName,
              colorFille: appColorFond,
              validatorMessage: "Veuillez saisir votre prénom",
            ),
            Gap(1.h),
            InputText(
              hintText: "E-mail",
              keyboardType: TextInputType.emailAddress,
              controller: email,
              colorFille: appColorFond,
            ),
            Gap(1.h),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 4.w),
              decoration: BoxDecoration(
                color: appColorFond,
                borderRadius: BorderRadius.circular(3.w),
                border: Border.all(
                  color: _isFocused ? appColorBorder : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Numéro de Téléphone",
                    style: TextStyle(
                      color: appColorBlack,
                      fontWeight: FontWeight.normal,
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    SharedPreferencesHelper().getString('phone')!,
                    style: TextStyle(
                      color: appColorBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
            Gap(1.h),
            InputText(
              hintText: "Commune*",
              keyboardType: TextInputType.text,
              controller: commune,
              colorFille: appColorFond,
              validatorMessage: "Veuillez saisir votre commune",
            ),
            Gap(1.h),
            InputText(
              hintText: "Adresse complete",
              keyboardType: TextInputType.text,
              controller: adresse,
              colorFille: appColorFond,
            ),
            Gap(1.h),
            InputText(
              hintText: "Annee d'experience",
              keyboardType: TextInputType.number,
              controller: annee,
              colorFille: appColorFond,
            ),
            Gap(1.h),
            InputPassword(
              hintText: "Nouveau mot de passe",
              controller: password,
              colorFille: appColorFond,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: appColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              ),
            ),
            Gap(1.h),
            InputPassword(
              hintText: "Confimer le mot de passe",
              controller: password,
              colorFille: appColorFond,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: appColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              ),
            ),
            Gap(2.h),
            SubmitButton(
              AppConstants.btnUpdate,
              onPressed: () async {
                if (_formKeyInfo.currentState!.validate() && _image != null) {
                  updatePictureUser(context, _image!);
                } else {
                  SnackbarHelper.showError(
                    context,
                    "Verifiez vos informations",
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updatePictureUser(BuildContext context, File imageFile) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: const [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Expanded(child: Text('Veuillez patienter...')),
            ],
          ),
        );
      },
    );

    try {
      HttpClient().badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      final uri = Uri.parse(
        "${ApiUrls.postUpdateInfoBasic}${SharedPreferencesHelper().getString('identifiant')}",
      );
      final request = http.MultipartRequest('POST', uri);

      // Ajoute les champs nécessaires
      request.fields['nom'] = name.text;
      request.fields['prenom'] = lastName.text;
      request.fields['commune'] = commune.text;
      request.fields['adresse'] = adresse.text;
      request.fields['experience'] = annee.text;
      request.fields['password'] = password.text;
      request.fields['email'] = email.text;

      // Ajoute le fichier image
      request.files.add(
        await http.MultipartFile.fromPath('photo', imageFile.path),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      Navigator.pop(context);

      print(response.statusCode);
      debugPrint(response.body, wrapWidth: 1024);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(
          utf8.decode(response.bodyBytes),
        );

        SharedPreferencesHelper().saveString('photo', responseData['photo']);

        SnackbarHelper.showSuccess(
          context,
          "Informations mises à jour avec succès",
        );
      } else {
        SnackbarHelper.showError(
          context,
          "Impossible de modifier vos informations. Veuillez réessayer.",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      SnackbarHelper.showError(context, "Erreur de connexion $e");
    }
  }

  Widget presentation(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: appColorWhite,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Form(
        key: _formKeyPresentation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Presentation",
              style: TextStyle(
                color: appColorText,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            Gap(2.h),
            Text(
              "Decrivez-vous en quelques mots",
              style: TextStyle(
                color: appColorText,
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
              ),
            ),
            Gap(1.h),
            InputText(
              hintText: "Ecrire...*",
              keyboardType: TextInputType.text,
              controller: present,
              maxLines: 5,
              colorFille: appColorFond,
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              validatorMessage: "Veuillez vous presentater",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Maximum 500 caracteres",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp,
                  ),
                ),
                Text(
                  "$_charCount/500",
                  style: TextStyle(
                    color: _charCount >= 500 ? Colors.red : appColorTextSecond,
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            Gap(2.h),
            SubmitButton(
              AppConstants.btnUpdate,
              onPressed: () async {
                if (_formKeyPresentation.currentState!.validate()) {
                  updatePresentation(context);
                } else {
                  SnackbarHelper.showError(
                    context,
                    "Verifiez votre presentation",
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updatePresentation(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text('Modification en cours...')),
            ],
          ),
        );
      },
    );

    try {
      // Autoriser les certificats auto-signés (attention en production)
      HttpClient().badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      final response = await http.post(
        Uri.parse(
          "${ApiUrls.postUpdatepresentation}${SharedPreferencesHelper().getString('identifiant')}",
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'presentation': present.text}),
      );

      final Map<String, dynamic> responseData = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      if (response.statusCode == 200) {
        // Sauvegarder la nouvelle presentation
        await Future.wait([
          SharedPreferencesHelper().saveString('presentation', present.text),
        ]);

        Navigator.pop(context);

        SnackbarHelper.showSuccess(context, responseData['message']);
      } else if (response.statusCode == 401) {
        Navigator.pop(context);
        SnackbarHelper.showWarning(context, responseData['message']);
      } else {
        Navigator.pop(context);
        SnackbarHelper.showError(
          context,
          "Impossible de modifier votre presentation. Veuillez réessayer!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      SnackbarHelper.showError(context, "Erreur de connexion");
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

      // 🔹 Ici, on sélectionne automatiquement celles dont isAssocie == 1
      selectedServices = specialites.where((s) => s.isAssocie == 1).toList();

      return specialites;
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  Widget specialites(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: appColorWhite,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Form(
        key: _formKeySpecial,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Specialites",
              style: TextStyle(
                color: appColorText,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            Gap(2.h),
            FutureBuilder<List<SpecialiteModel>>(
              future: _futureSpecialites,
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
                      "Impossible d'avoir les specialites disponibles. "
                      "Verifiez votre internet. Si le probleme "
                      "persiste veuillez contactez AFROLIA",
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (snapshot.hasData) {
                  allSpecialites = snapshot.data!;

                  if (allSpecialites.isEmpty) {
                    return Center(child: Text("Pas de Specialite disponible"));
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allSpecialites.length,
                    itemBuilder: (context, index) {
                      final service = allSpecialites[index];
                      final isSelected = selectedServices.contains(service);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              // Si déjà sélectionné -> retirer
                              selectedServices.remove(service);
                            } else {
                              // Sinon -> ajouter
                              selectedServices.add(service);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? appColorFond : appColorWhite,
                            border: Border.all(
                              color: isSelected
                                  ? appColorOrange
                                  : appColorBorder,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(3.w),
                          ),
                          child: Center(
                            child: Text(
                              service.libelle!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected
                                    ? appColorText
                                    : appColorTextThree,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(child: Text("Aucune donnée disponible"));
              },
            ),
            Gap(2.h),
            Text(
              "Selectionnez vos specialites principales",
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.normal,
                fontSize: 15.sp,
              ),
            ),
            Gap(1.h),
            SubmitButton(
              AppConstants.btnUpdate,
              onPressed: () async {
                if (selectedServices.isEmpty) {
                  SnackbarHelper.showError(
                    context,
                    "Veuillez sélectionner au moins une spécialité",
                  );
                } else {
                  await sendSelectedSpecialites();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendSelectedSpecialites() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text('Modification en cours...')),
            ],
          ),
        );
      },
    );

    final identifiant = SharedPreferencesHelper().getString('identifiant');

    List<int> selectedIds = selectedServices
        .map((s) => s.idSpecialite!)
        .toList();

    final body = jsonEncode({
      'id_utilisateur': identifiant,
      'specialites': selectedIds,
    });

    print(body);

    final response = await http.post(
      Uri.parse(ApiUrls.postAssociationSpecialiste),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    Navigator.pop(context);

    if (response.statusCode == 200) {
      SnackbarHelper.showSuccess(
        context,
        "Vos spécialités ont été mises à jour avec succès !",
      );
    } else {
      SnackbarHelper.showError(context, "Erreur lors de la mise à jour");
    }
  }

  Future<List<LaguageModel>> fetchLanguages() async {
    final http.Response response = await http.get(
      Uri.parse(
        "${ApiUrls.getListAssoLanguage}${SharedPreferencesHelper().getString('identifiant')}",
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(
        utf8.decode(response.bodyBytes),
      );

      final List<dynamic> contentList = jsonResponse['data'];

      List<LaguageModel> languages = contentList
          .map((item) => LaguageModel.fromJson(item as Map<String, dynamic>))
          .toList();

      // 🔹 Ici, on sélectionne automatiquement celles dont isAssocie == 1
      selectedLanguages = languages.where((s) => s.isAssocie == 1).toList();

      return languages;
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  Widget languages(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: appColorWhite,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Form(
        key: _formKeyLanguage,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Langues parlées",
              style: TextStyle(
                color: appColorText,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            Gap(2.h),
            FutureBuilder<List<LaguageModel>>(
              future: _futureLanguages,
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
                      "Impossible d'avoir les langues disponibles. "
                      "Verifiez votre internet. Si le probleme "
                      "persiste veuillez contactez AFROLIA",
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (snapshot.hasData) {
                  allLanguages = snapshot.data!;

                  if (allLanguages.isEmpty) {
                    return Center(child: Text("Pas de Langue disponible"));
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allLanguages.length,
                    itemBuilder: (context, index) {
                      final service = allLanguages[index];
                      final isSelected = selectedLanguages.contains(service);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              // Si déjà sélectionné -> retirer
                              selectedLanguages.remove(service);
                            } else {
                              // Sinon -> ajouter
                              selectedLanguages.add(service);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? appColorFond : appColorWhite,
                            border: Border.all(
                              color: isSelected
                                  ? appColorOrange
                                  : appColorBorder,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(3.w),
                          ),
                          child: Center(
                            child: Text(
                              service.libelle!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected
                                    ? appColorText
                                    : appColorTextThree,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(child: Text("Aucune donnée disponible"));
              },
            ),
            Gap(2.h),
            Text(
              "Selectionnez vos langues parlées",
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.normal,
                fontSize: 15.sp,
              ),
            ),
            Gap(1.h),
            SubmitButton(
              AppConstants.btnUpdate,
              onPressed: () async {
                if (selectedLanguages.isEmpty) {
                  SnackbarHelper.showError(
                    context,
                    "Veuillez sélectionner au moins une langue",
                  );
                } else {
                  await sendSelectedLanguages();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendSelectedLanguages() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text('Modification en cours...')),
            ],
          ),
        );
      },
    );

    final identifiant = SharedPreferencesHelper().getString('identifiant');

    List<int> selectedIds = selectedLanguages.map((s) => s.idLangue!).toList();

    final body = jsonEncode({
      'id_utilisateur': identifiant,
      'langues': selectedIds,
    });

    print(body);

    final response = await http.post(
      Uri.parse(ApiUrls.postAssociationLanguage),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print(response.body);
    print(response.statusCode);

    Navigator.pop(context);

    if (response.statusCode == 200) {
      SnackbarHelper.showSuccess(
        context,
        "Vos langues ont été mises à jour avec succès !",
      );
    } else {
      SnackbarHelper.showError(context, "Erreur lors de la mise à jour");
    }
  }
}

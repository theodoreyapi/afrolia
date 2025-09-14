import 'dart:io';

import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:afrolia/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
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
  late final bool _isChecked = true;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  late int _charCount = 0;

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
  }

  var login = TextEditingController();
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
                              child: _image == null
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
                                  icon: Icon(
                                    Icons.image,
                                    size: 18,
                                    color: appColorWhite,
                                  ),
                                  onPressed: _pickImage,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(2.5.h),
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

  List<Service> selectedServices = [];

  // Liste des services disponibles
  final List<Service> services = [
    Service(name: "Tresses", id: 1),
    Service(name: "Locks", id: 2),
    Service(name: "Tissage", id: 3),
    Service(name: "Defrisage", id: 4),
    Service(name: "Coupe", id: 5),
    Service(name: "Soins", id: 6),
    Service(name: "Coloration", id: 7),
    Service(name: "Extensions", id: 8),
    Service(name: "Lissage", id: 9),
    Service(name: "Permanente", id: 10),
  ];
  List<Languages> selectedLanguages = [];

  // Liste des langues disponibles
  final List<Languages> langages = [
    Languages(name: "Attie", id: 1),
    Languages(name: "Francais", id: 2),
    Languages(name: "Anglais", id: 3),
    Languages(name: "Dioula", id: 4),
    Languages(name: "Baoule", id: 5),
    Languages(name: "Bete", id: 6),
    Languages(name: "Senoufo", id: 7),
    Languages(name: "Abron", id: 8),
    Languages(name: "Agni", id: 9),
    Languages(name: "Gouro", id: 10),
  ];

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
              hintText: "Email",
              keyboardType: TextInputType.emailAddress,
              controller: email,
              colorFille: appColorFond,
            ),
            Gap(1.h),
            Container(
              padding: EdgeInsets.only(left: 4.w),
              decoration: BoxDecoration(
                color: appColorFond,
                borderRadius: BorderRadius.circular(3.w),
                border: Border.all(
                  color: _isFocused ? appColorBorder : Colors.transparent,
                  width: 2,
                ),
              ),
              child: InternationalPhoneNumberInput(
                focusNode: _focusNode,
                onInputChanged: (PhoneNumber number) {
                  phoneIndicator = number.phoneNumber!;
                },
                onInputValidated: (bool value) {},
                errorMessage: "Le numéro est invalide",
                hintText: "Téléphone*",
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: const TextStyle(color: Colors.black),
                //countries: ['CI'],
                initialValue: number,
                textFieldController: login,
                formatInput: true,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                inputBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                onSaved: (PhoneNumber number) {},
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
              hintText: "Mot de passe",
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
                if (_formKeyPresentation.currentState!.validate() &&
                    _image != null) {
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
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
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
                        color: isSelected ? appColorOrange : appColorBorder,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    child: Center(
                      child: Text(
                        service.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? appColorText : appColorTextThree,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                );
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
                if (_formKeySpecial.currentState!.validate() &&
                    _image != null) {
                } else {
                  SnackbarHelper.showError(context, "Verifiez la selection");
                }
              },
            ),
          ],
        ),
      ),
    );
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
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: langages.length,
              itemBuilder: (context, index) {
                final service = langages[index];
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
                        color: isSelected ? appColorOrange : appColorBorder,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    child: Center(
                      child: Text(
                        service.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? appColorText : appColorTextThree,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                );
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
                if (_formKeyLanguage.currentState!.validate() &&
                    _image != null) {
                } else {
                  SnackbarHelper.showError(context, "Verifiez la selection");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Service {
  final String name;
  final int id;

  Service({required this.name, required this.id});
}
class Languages {
  final String name;
  final int id;

  Languages({required this.name, required this.id});
}

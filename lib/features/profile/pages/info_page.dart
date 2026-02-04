import 'dart:convert';
import 'dart:io';

import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  late final bool _isChecked = true;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  var login = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var name = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var commune = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    commune.text = SharedPreferencesHelper().getString('commune')!;
    email.text = SharedPreferencesHelper().getString('email')!;
    name.text = SharedPreferencesHelper().getString('nom')!;
    lastName.text = SharedPreferencesHelper().getString('prenom')!;
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
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Form(
            key: _formKey,
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
                      "Mes informations",
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
                        InputText(
                          hintText: "Nom",
                          keyboardType: TextInputType.text,
                          controller: name,
                          validatorMessage: "Veuillez saisir votre nom",
                        ),
                        Gap(1.h),
                        InputText(
                          hintText: "Prénoms",
                          keyboardType: TextInputType.text,
                          controller: lastName,
                          validatorMessage: "Veuillez saisir votre prénom",
                        ),
                        Gap(1.h),
                        InputText(
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                          validatorMessage:
                              "Veuillez saisir votre adresse email",
                        ),
                        Gap(1.h),
                        InputText(
                          hintText: "Commune*",
                          keyboardType: TextInputType.text,
                          controller: commune,
                          validatorMessage: "Veuillez saisir votre commune",
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
                        InputPassword(
                          hintText: "Mot de passe",
                          controller: password,
                          validatorMessage:
                              "Veuillez saisir votre mot de passe",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
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
                          validatorMessage:
                              "Veuillez saisir votre mot de passe",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: appColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
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
        padding: EdgeInsets.all(5.w),
        child: SubmitButton(
          AppConstants.btnInfo,
          onPressed: () async {
            if (_formKey.currentState!.validate() && _image != null) {
              updatePictureUser(context, _image!);
            } else {
              SnackbarHelper.showError(
                context,
                "Tous les champs sont obligatoires",
              );
            }
          },
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

}

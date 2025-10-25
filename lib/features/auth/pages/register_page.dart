import 'dart:convert';
import 'dart:io';

import 'package:afrolia/features/security/security.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../../../core/widgets/inputs/inputs.dart';
import '../auth.dart';

class RegisterPage extends StatefulWidget {
  String? texte;

  RegisterPage({super.key, this.texte});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  late bool _isChecked = true;

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
  }

  var login = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var name = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String phoneIndicator = "";
  String initialCountry = 'CI';
  PhoneNumber number = PhoneNumber(isoCode: 'CI');

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
                      "Inscription ${widget.texte}",
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
                        ),
                        Gap(1.h),
                        Container(
                          padding: EdgeInsets.only(left: 4.w),
                          decoration: BoxDecoration(
                            color: appColorWhite,
                            borderRadius: BorderRadius.circular(3.w),
                            border: Border.all(
                              color: _isFocused
                                  ? appColorBorder
                                  : Colors.transparent,
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
                            hintText: "Téléphone",
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: const TextStyle(
                              color: Colors.black,
                            ),
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
                          controller: confirmPassword,
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
                        Gap(2.h),
                        SubmitButton(
                          AppConstants.btnCreate,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (password.text == confirmPassword.text) {
                                registerUser(context);
                              } else {
                                SnackbarHelper.showError(
                                  context,
                                  "Les mots de passe ne correspondent pas",
                                );
                              }
                            } else {
                              SnackbarHelper.showError(
                                context,
                                "Tous les champs sont obligatoires",
                              );
                            }
                          },
                        ),
                        Gap(2.h),
                        Row(
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: appColorBlack,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text:
                                          "En vous inscrivant, vous acceptez nos ",
                                    ),
                                    TextSpan(
                                      text: "Conditions d’utilisation",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        color: appColor,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          showBarModalBottomSheet(
                                            isDismissible: false,
                                            enableDrag: false,
                                            expand: true,
                                            topControl: Align(
                                              alignment: Alignment.centerLeft,
                                              child: FloatingActionButton.small(
                                                heroTag: "Condition",
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
                                                ConditionPage(),
                                          );
                                        },
                                    ),
                                    const TextSpan(text: " et notre "),
                                    TextSpan(
                                      text: "Politique de confidentialité",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        color: appColor,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          showBarModalBottomSheet(
                                            isDismissible: false,
                                            enableDrag: false,
                                            expand: true,
                                            topControl: Align(
                                              alignment: Alignment.centerLeft,
                                              child: FloatingActionButton.small(
                                                heroTag: "Politique",
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
                                            builder: (context) => PolicyPage(),
                                          );
                                        },
                                    ),
                                    const TextSpan(text: "."),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(1.h),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => LoginPage()),
                              );
                            },
                            child: Text(
                              "Déjà inscrit ? ${AppConstants.btnLogin}",
                              style: TextStyle(
                                color: appColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
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
    );
  }

  Future<void> registerUser(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: appColor,
          surfaceTintColor: appColor,
          shadowColor: appColor,
          content: Row(
            children: [
              CircularProgressIndicator(color: appColorWhite),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  'Création du compte...',
                  style: TextStyle(color: appColorWhite),
                ),
              ),
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
        Uri.parse(ApiUrls.postRegister),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nom': name.text,
          'prenom': lastName.text,
          'phone': phoneIndicator.isEmpty ? login.text : phoneIndicator,
          'email': email.text,
          'password': password.text,
          'role': widget.texte == "Cliente" ? 'user' : 'hair',
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);

        SnackbarHelper.showSuccess(context, responseData['message']);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      } else if (response.statusCode == 401) {
        Navigator.pop(context);
        SnackbarHelper.showError(context, responseData['message']);
      } else if (response.statusCode == 422) {
        Navigator.pop(context);
        final message = responseData['message'];
        if (message is List && message.isNotEmpty) {
          SnackbarHelper.showError(context, message.first);
        } else if (message is String) {
          SnackbarHelper.showError(context, message);
        } else {
          SnackbarHelper.showError(context, "Une erreur est survenue.");
        }
      } else {
        Navigator.pop(context);
        SnackbarHelper.showError(
          context,
          "Impossible de s'enregistrer. Veuillez réessayer!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      SnackbarHelper.showError(context, "Erreur de connexion");
    }
  }
}

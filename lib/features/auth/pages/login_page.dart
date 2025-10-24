import 'dart:convert';
import 'dart:io';

import 'package:afrolia/features/coiffeuse/menupro/pages/menupro_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../../../core/widgets/inputs/inputs.dart';
import '../../menu/pages/menu_page.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

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

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  var login = TextEditingController();
  var password = TextEditingController();

  String phoneIndicator = "";
  String initialCountry = 'CI';
  PhoneNumber number = PhoneNumber(isoCode: 'CI');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      "Connexion",
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.w),
                            gradient: LinearGradient(
                              colors: [appColorOrange, appColor],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3.w),
                            child: Padding(
                              padding: EdgeInsets.all(3.w),
                              child: Image.asset(
                                "assets/images/logo-remove.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Gap(1.h),
                        Text(
                          "Bon retour !",
                          style: TextStyle(
                            color: appColorText,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Connectez-vous a votre compte",
                          style: TextStyle(
                            color: appColorTextSecond,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Gap(5.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                        Gap(2.h),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ForgotPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Mot de passe oublié ?",
                              style: TextStyle(
                                color: appColorTextSecond,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        Gap(4.h),
                        SubmitButton(
                          AppConstants.btnLogin,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              loginUser(context);
                            } else {
                              SnackbarHelper.showError(
                                context,
                                "Tous les champs sont obligatoires",
                              );
                            }
                          },
                        ),
                        Gap(3.h),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => ChoiseRegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Pas encore de compte ? ${AppConstants.btnRegister}",
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

  Future<void> loginUser(BuildContext context) async {
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
                  'Authentification...',
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
        Uri.parse(ApiUrls.postLogin),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'login': phoneIndicator.isEmpty ? login.text : phoneIndicator,
          'password': password.text,
        }),
      );
      final Map<String, dynamic> responseData = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      if (response.statusCode == 200) {
        // Sauvegarder toutes les infos utilisateur
        await Future.wait([
          SharedPreferencesHelper().saveString(
            'identifiant',
            responseData['data']['id'].toString(),
          ),
          SharedPreferencesHelper().saveString(
            'presentation',
            responseData['data']['presentation'],
          ),
          SharedPreferencesHelper().saveString(
            'email',
            responseData['data']['email'],
          ),
          SharedPreferencesHelper().saveString(
            'nom',
            responseData['data']['nom'],
          ),
          SharedPreferencesHelper().saveString(
            'prenom',
            responseData['data']['prenom'],
          ),
          SharedPreferencesHelper().saveString(
            'phone',
            responseData['data']['phone'],
          ),
          SharedPreferencesHelper().saveString(
            'adresse',
            responseData['data']['adresse'],
          ),
          SharedPreferencesHelper().saveInteger(
            'experience',
            responseData['data']['experience'],
          ),
          SharedPreferencesHelper().saveString(
            'commune',
            responseData['data']['commune'],
          ),
          SharedPreferencesHelper().saveString(
            'role',
            responseData['data']['role'],
          ),
          SharedPreferencesHelper().saveString(
            'photo',
            responseData['data']['photo'],
          ),
          SharedPreferencesHelper().saveString(
            'creation',
            responseData['data']['creation'],
          ),
        ]);

        Navigator.pop(context);

        SnackbarHelper.showSuccess(context, responseData['message']);

        if (responseData['data']['role'] == 'user') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MenuPage()),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MenuproPage()),
            (route) => false,
          );
        }
      } else if (response.statusCode == 401) {
        Navigator.pop(context);
        SnackbarHelper.showWarning(context, responseData['message']);
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
          "Impossible de se connecter. Veuillez réessayer!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      SnackbarHelper.showError(context, "Erreur de connexion");
    }
  }
}

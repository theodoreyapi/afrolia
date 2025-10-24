import 'dart:convert';
import 'dart:io';

import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:afrolia/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

class ReseauPage extends StatefulWidget {
  const ReseauPage({super.key});

  @override
  State<ReseauPage> createState() => _ReseauPageState();
}

class _ReseauPageState extends State<ReseauPage> {
  final _formKeyInfo = GlobalKey<FormState>();

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      sociaux();
    });
  }

  var insta = TextEditingController();
  var face = TextEditingController();
  var whats = TextEditingController();
  var tiktok = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String phoneIndicator = "";
  String initialCountry = 'CI';
  PhoneNumber number = PhoneNumber(isoCode: 'CI');

  Future<void> sociaux() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text('Patientez...')),
            ],
          ),
        );
      },
    );
    final http.Response response = await http.get(
      Uri.parse(
        "${ApiUrls.getFirstSociaux}${SharedPreferencesHelper().getString('identifiant')}",
      ),
      headers: {'Content-Type': 'application/json'},
    );

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(
        utf8.decode(response.bodyBytes),
      );

      setState(() {
        insta.text = jsonResponse['instagram'];
        face.text = jsonResponse['facebook'];
        whats.text = jsonResponse['whatsapp'];
        tiktok.text = jsonResponse['tiktok'];
      });
    } else {
      SnackbarHelper.showError(context, "Veuillez remplir les champs.");
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
                  Text(
                    "Reseaux sociaux",
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      informations(context),
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
                              Icons.workspace_premium_outlined,
                              color: appColorTextThree,
                            ),
                            Gap(2.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Visibilité accrue",
                                    style: TextStyle(
                                      color: appColorText,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Ajoutez vos réseaux sociaux pour permettre "
                                    "aux clientes de découvrir votre travail "
                                    "et augmenter votre visibilité sur la plateforme.",
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
    );
  }

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
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/nstagram.svg",
                  height: 2.h,
                  width: 2.h,
                ),
                Gap(1.w),
                Text(
                  "Instagram",
                  style: TextStyle(
                    color: appColorText,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            InputText(
              hintText: "@theoyapi",
              keyboardType: TextInputType.text,
              controller: insta,
              colorFille: appColorFond,
              validatorMessage: "Obligatoire",
            ),
            Gap(1.h),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/facebook.svg",
                  height: 2.h,
                  width: 2.h,
                ),
                Gap(1.w),
                Text(
                  "Facebook",
                  style: TextStyle(
                    color: appColorText,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            InputText(
              hintText: "Theodore Yapi",
              keyboardType: TextInputType.text,
              controller: face,
              colorFille: appColorFond,
              validatorMessage: "Obligatoire",
            ),
            Gap(1.h),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/whatsapp.svg",
                  height: 2.h,
                  width: 2.h,
                ),
                Gap(1.w),
                Text(
                  "WhatsApp",
                  style: TextStyle(
                    color: appColorText,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            InputText(
              hintText: "05 85 83 1647",
              keyboardType: TextInputType.phone,
              controller: whats,
              colorFille: appColorFond,
              validatorMessage: "Obligatoire",
            ),
            Gap(1.h),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/tictok.svg",
                  height: 2.h,
                  width: 2.h,
                ),
                Gap(1.w),
                Text(
                  "TikTok",
                  style: TextStyle(
                    color: appColorText,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            InputText(
              hintText: "@yapastuce",
              keyboardType: TextInputType.text,
              controller: tiktok,
              colorFille: appColorFond,
              validatorMessage: "Obligatoire",
            ),
            Gap(2.h),
            SubmitButton(
              AppConstants.btnUpdate,
              onPressed: () async {
                if (_formKeyInfo.currentState!.validate()) {
                  addSociaux();
                } else {
                  SnackbarHelper.showError(
                    context,
                    "Tous les champs sont obligatoires",
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addSociaux() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text('Mise a jour...')),
            ],
          ),
        );
      },
    );
    final http.Response response = await http.post(
      Uri.parse(ApiUrls.postSaveSociaux),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id_utilisateur': SharedPreferencesHelper().getString('identifiant'),
        'instagram': insta.text,
        'facebook': face.text,
        'whatsapp': whats.text,
        'tiktok': tiktok.text,
      }),
    );

    Navigator.pop(context);

    if (response.statusCode == 200) {
      SnackbarHelper.showSuccess(context, "Vos informations ont été mise a jour");
    } else {
      SnackbarHelper.showError(context, "Veuillez remplir les champs.");
      throw Exception("Une erreur s'est produite");
    }
  }
}

import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/utils/utils.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:afrolia/models/hair/services/service_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class EditServicePage extends StatefulWidget {
  const EditServicePage({super.key, required ServiceModel service});

  @override
  State<EditServicePage> createState() => _EditServicePageState();
}

class _EditServicePageState extends State<EditServicePage> {
  final _formKeyInfo = GlobalKey<FormState>();

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

    serviceController.text = SharedPreferencesHelper().getString('commune')!;
    prixController.text = SharedPreferencesHelper().getString('adresse')!;
    descriptionController.text = SharedPreferencesHelper()
        .getInt('experience')!
        .toString();
    dureController.text = SharedPreferencesHelper().getString('presentation')!;
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
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
                              "Service",
                              style: TextStyle(
                                color: appColorText,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                        Gap(2.h),
                        InputText(
                          hintText: "Nom du service*",
                          keyboardType: TextInputType.text,
                          controller: serviceController,
                          colorFille: appColorFond,
                          validatorMessage: "Veuillez saisir le nom",
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
            if (_formKeyInfo.currentState!.validate()) {
            } else {
              SnackbarHelper.showError(context, "Verifiez les informations");
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
}

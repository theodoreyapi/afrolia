import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/app_constant.dart';
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
}

class _ServicePageState extends State<ServicePage> {
  final List<ServiceForm> servicesForms = [ServiceForm()];

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
                  for (var form in servicesForms) {
                    if (!(form._formKeyInfo.currentState?.validate() ?? false)) {
                      return false;
                    } else {
                      SnackbarHelper.showError(context, "Verifiez vos informations");
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
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
            InputText(
              hintText: "Nom du service*",
              keyboardType: TextInputType.text,
              controller: serviceForm.serviceController,
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

}

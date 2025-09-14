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

class DisponiblePage extends StatefulWidget {
  const DisponiblePage({super.key});

  @override
  State<DisponiblePage> createState() => _DisponiblePageState();
}

class _DisponiblePageState extends State<DisponiblePage> {
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
                    "Mes disponibilites",
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
                      planning(context),
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
                              Icons.emoji_objects_outlined,
                              color: appColorTextThree,
                            ),
                            Gap(2.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Conseil",
                                    style: TextStyle(
                                      color: appColorText,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Plus vous avez de créneaux disponibles, "
                                    "plus vous avez de chances d'avoir des "
                                    "réservations. Vous pouvez toujours "
                                    "bloquer des créneaux ponctuellement.",
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
        child: SubmitButton(
          AppConstants.btnUpdate,
          onPressed: () async {
            SnackbarHelper.showError(context, "Verifiez la selection");
          },
        ),
      ),
    );
  }

  // Liste des heures
  final List<Horaire> heures = List.generate(
    15, // de 08:00 à 22:00
    (index) => Horaire(
      name: "${(8 + index).toString().padLeft(2, '0')}:00",
      id: index + 1,
    ),
  );

  // Liste des jours
  final List<String> jours = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samedi",
    "Dimanche",
  ];

  // Map pour stocker la sélection par jour
  late Map<String, List<Horaire>> selectedByDay = {
    for (var jour in jours) jour: [],
  };

  Widget planning(BuildContext context) {
    return Column(
      children: jours.map((jour) {
        return Container(
          margin: EdgeInsets.only(bottom: 2.h),
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: appColorWhite,
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Titre du jour
              Text(
                jour,
                style: TextStyle(
                  color: appColorText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              Gap(2.h),

              /// GridView des heures
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: heures.length,
                itemBuilder: (context, index) {
                  final horaire = heures[index];
                  final isSelected = selectedByDay[jour]!.contains(horaire);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedByDay[jour]!.remove(horaire);
                        } else {
                          selectedByDay[jour]!.add(horaire);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? appColor : appColorBorder,
                        border: Border.all(
                          color: isSelected ? appColor : appColorBorder,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: Center(
                        child: Text(
                          horaire.name,
                          style: TextStyle(
                            color: isSelected
                                ? appColorWhite
                                : appColorTextSecond,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class Horaire {
  final String name;
  final int id;

  Horaire({required this.name, required this.id});
}

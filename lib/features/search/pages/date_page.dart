import 'dart:convert';

import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/widgets/buttons/submit_button.dart';
import 'package:afrolia/features/search/pages/reservation_config_page.dart';
import 'package:afrolia/models/hair/services/service_model.dart';
import 'package:afrolia/models/user/salons/salon_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

import '../../../models/hair/disponibilites/disponibilite_model.dart';

class DatePage extends StatefulWidget {
  ServiceModel? service;
  SalonModel? salon;

  DatePage({super.key, this.service, this.salon});

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  DateTime? selectedDate;
  String? selectedTime;

  bool isLoadingHours = false;
  List<String> availableHours = [];

  // Horaires disponibles
  List<String> getAvailableTimes() {
    return [
      "09:00",
      "10:00",
      "11:00",
      "12:00",
      "13:00",
      "14:00",
      "15:00",
      "16:00",
      "17:00",
    ];
  }

  Future<void> fetchDisponibilitesParJour(DateTime date) async {
    setState(() {
      isLoadingHours = true;
      availableHours = [];
    });

    final response = await http.get(
      Uri.parse("${ApiUrls.getListDisponibility}${widget.salon!.id}"),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      List<DisponibiliteModel> disponibilites =
      data.map((e) => DisponibiliteModel.fromJson(e)).toList();

      /// Convertit la date sélectionnée → Nom du jour
      final jour = DateFormat('EEEE', 'fr_FR').format(date); // ex: lundi

      /// Trouver la disponibilité qui correspond au jour
      final dispoJour = disponibilites.firstWhere(
            (d) => d.jour!.toLowerCase() == jour.toLowerCase(),
        orElse: () => DisponibiliteModel(heures: []),
      );

      setState(() {
        availableHours = dispoJour.heures ?? [];
        isLoadingHours = false;
      });
    } else {
      setState(() => isLoadingHours = false);
      throw Exception("Erreur API");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(2.w),
          child: FloatingActionButton.small(
            elevation: 0,
            backgroundColor: appColorBorder,
            shape: CircleBorder(),
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_outlined, color: appColorTextSecond),
          ),
        ),
        title: Text(
          "Choisir l'horaire",
          style: TextStyle(color: appColorText, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: CircleAvatar(
              backgroundColor: appColorBorder,
              child: Text(
                "2/4",
                style: TextStyle(
                  color: appColorText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 2.w),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColorWhite,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(3.w),
                            child: Image.network(
                              widget.salon!.photo!,
                              height: 7.h,
                              width: 7.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/images/logo.png",
                                  fit: BoxFit.cover,
                                  height: 7.h,
                                  width: 7.h,
                                );
                              },
                            ),
                          ),
                          Gap(2.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.salon!.nomComplet!,
                                  style: TextStyle(
                                    color: appColorText,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Gap(1.h),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.location_on_outlined,
                                          size: 16,
                                          color: appColorBlack,
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.salon!.commune!,
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 2.w),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.w),
                    border: Border.all(width: 2, color: appColorBorder),
                  ),
                  child: ListTile(
                    title: Text(
                      widget.service!.specialite!.libelle!,
                      style: TextStyle(
                        color: appColorText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.service!.minute! ~/ 60}h "
                          "${widget.service!.minute! % 60}min",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: appColorTextSecond,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " - ${widget.service!.prix!} FCFA",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: appColorTextSecond,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Modifier",
                        style: TextStyle(
                          color: appColorTextThree,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Choisissez une date",
                  style: TextStyle(
                    color: appColorText,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(1.h),
                EasyDateTimeLine(
                  initialDate: DateTime.now(),
                  onDateChange: (date) {
                    setState(() {
                      selectedDate = date;
                      selectedTime = null;
                    });

                    fetchDisponibilitesParJour(date);
                  },
                  activeColor: appColor,
                  dayProps: EasyDayProps(
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3.w)),
                        color: appColorWhite,
                      ),
                      monthStrStyle: TextStyle(color: appColorText),
                      dayStrStyle: TextStyle(color: appColorText),
                      dayNumStyle: TextStyle(
                        color: appColorText,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  locale: "fr",
                ),
                Gap(2.h),
                if (selectedDate != null) ...[
                  Text(
                    "Choisissez un créneau",
                    style: TextStyle(
                      color: appColorText,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Gap(1.h),

                  isLoadingHours
                      ? Center(child: CircularProgressIndicator())
                      : availableHours.isEmpty
                      ? Text("Aucun créneau disponible pour cette date")
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: availableHours.length,
                    itemBuilder: (context, index) {
                      final time = availableHours[index];
                      final isSelected = selectedTime == time;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTime = time;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? appColor : appColorWhite,
                            border: Border.all(color: appColorBorder),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              time,
                              style: TextStyle(
                                color: isSelected
                                    ? appColorWhite
                                    : appColorText,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selectedDate != null && selectedTime != null) ...[
              Gap(2.h),
              SubmitButton(
                AppConstants.btnContinue,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationConfigPage(
                        salon: widget.salon!,
                        service: widget.service!,
                        date: selectedDate!,
                        time: selectedTime!,
                      ),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),

    );
  }
}

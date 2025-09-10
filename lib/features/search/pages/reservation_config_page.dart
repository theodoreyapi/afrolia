import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:afrolia/features/search/pages/reservation_page.dart';
import 'package:afrolia/features/search/search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ReservationConfigPage extends StatefulWidget {
  Service? service;
  DateTime? date;
  String? time;

  ReservationConfigPage({super.key, this.service, this.date, this.time});

  @override
  State<ReservationConfigPage> createState() => _ReservationConfigPageState();
}

class _ReservationConfigPageState extends State<ReservationConfigPage> {
  String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('EEEE d MMMM y', 'fr_FR');
    final commission = (widget.service!.price * 0.15).toInt();
    final totalAmount = widget.service!.price + commission;

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
          "Confirmer la réservation",
          style: TextStyle(color: appColorText, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: CircleAvatar(
              backgroundColor: appColorBorder,
              child: Text(
                "3/4",
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
                            child: Image.asset(
                              "assets/images/gal2.jpg",
                              height: 7.h,
                            ),
                          ),
                          Gap(2.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amina Diallo",
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
                                        text: " Marcory, Abidjan",
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
                Text(
                  "Récapitulatif de la réservation",
                  style: TextStyle(
                    color: appColorText,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(1.h),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 2.w),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColorWhite,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Service",
                        style: TextStyle(
                          color: appColorText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.service!.name,
                            style: TextStyle(
                              color: appColorText,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${widget.service!.price} FCFA",
                            style: TextStyle(
                              color: appColorTextThree,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.service!.description,
                        style: TextStyle(
                          color: appColorBlack,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Gap(1.h),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.access_time_outlined,
                                size: 16,
                                color: appColorTextThree,
                              ),
                            ),
                            TextSpan(
                              text:
                                  " Durée: ${widget.service!.duration ~/ 60}h "
                                  "${widget.service!.duration % 60}min",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: appColorTextThree,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(2.h),
                      Text(
                        "Date & heure",
                        style: TextStyle(
                          color: appColorText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(1.h),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.calendar_today_outlined,
                                    size: 16,
                                    color: appColorTextSecond,
                                  ),
                                ),
                                TextSpan(
                                  text: " ${formatter.format(widget.date!)}",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: appColorTextSecond,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(2.w),
                          Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.access_time_outlined,
                                    size: 16,
                                    color: appColorTextSecond,
                                  ),
                                ),
                                TextSpan(
                                  text: " 10h0min",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: appColorTextSecond,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Gap(2.h),
                      Text(
                        "Détail du prix",
                        style: TextStyle(
                          color: appColorText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Prix du service",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "${widget.service!.price} FCFA",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Commission Afrolia (15%)",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "$commission FCFA",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Gap(1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total à payer",
                            style: TextStyle(
                              color: appColorText,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "$totalAmount FCFA",
                            style: TextStyle(
                              color: appColorTextThree,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 2.w),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColorWhite,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Méthode de paiement",
                        style: TextStyle(
                          color: appColorText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(1.h),
                      Container(
                        decoration: BoxDecoration(
                          color: selectedMethod == "card" ? appColorFond : appColorWhite,
                          borderRadius: BorderRadius.circular(3.w),
                          border: Border.all(
                            color: selectedMethod == "card" ? appColorOrange : appColorBorder,
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(3.w),
                          onTap: () {
                            setState(() {
                              selectedMethod = "card";
                            });
                          },
                          title: Text(
                            "Carte bancaire",
                            style: TextStyle(
                              color: appColorText,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "Visa, Mastercard, American Express",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 15.sp,
                            ),
                          ),
                          leading: Container(
                            height: 15.h,
                            width: 15.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.w),
                              gradient: LinearGradient(
                                colors: [Colors.blue, Colors.deepPurple],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Icon(Icons.credit_card_outlined, color: appColorWhite),
                          ),
                          trailing: Radio<String>(
                            value: "card",
                            groupValue: selectedMethod,
                            onChanged: (value) {
                              setState(() {
                                selectedMethod = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Gap(2.h),
                      Container(
                        decoration: BoxDecoration(
                          color: selectedMethod == "mobile" ? appColorFond : appColorWhite,
                          borderRadius: BorderRadius.circular(3.w),
                          border: Border.all(
                            color: selectedMethod == "mobile" ? appColorOrange : appColorBorder,
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(3.w),
                          onTap: () {
                            setState(() {
                              selectedMethod = "mobile";
                            });
                          },
                          title: Text(
                            "Mobile Money",
                            style: TextStyle(
                              color: appColorText,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "Orange Money, MTN Money, Moov Money",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 15.sp,
                            ),
                          ),
                          leading: Container(
                            height: 15.h,
                            width: 15.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.w),
                              gradient: LinearGradient(
                                colors: [appColorOrange, appColor],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Icon(Icons.phone_android_outlined, color: appColorWhite),
                          ),
                          trailing: Radio<String>(
                            value: "mobile",
                            groupValue: selectedMethod,
                            onChanged: (value) {
                              setState(() {
                                selectedMethod = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Gap(2.h),
                      Container(
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: appColorFond,
                          borderRadius: BorderRadius.circular(3.w),
                          border: Border.all(color: appColorBorder, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: appColorBorder,
                              child: Icon(
                                Icons.beenhere_outlined,
                                color: appColorTextThree,
                              ),
                            ),
                            Gap(2.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Paiement 100% sécurisé",
                                    style: TextStyle(
                                      color: appColorText,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Vos données bancaires sont protégées par un "
                                    "cryptage SSL 256 bits. Aucune information "
                                    "de paiement n'est stockée sur nos serveurs.",
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 2.w),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColorWhite,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sous-total service",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "${widget.service!.price} FCFA",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Gap(.5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Commission Afrolia (15%)",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "$commission FCFA",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Gap(.5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Frais de paiement",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "Gratuit",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Gap(1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total à payer",
                            style: TextStyle(
                              color: appColorText,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "$totalAmount FCFA",
                            style: TextStyle(
                              color: appColorTextThree,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(4.w),
        child: SubmitButtonIcon(
          "Payer $totalAmount FCFA",
          icone: Icon(Icons.credit_score_outlined, color: appColorWhite, size: 22,),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

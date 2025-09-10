import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:afrolia/features/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({super.key});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
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
          "Réservation confirmée",
          style: TextStyle(color: appColorText, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: CircleAvatar(
              backgroundColor: appColorBorder,
              child: Text(
                "4/4",
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
                Gap(2.h),
                Center(
                  child: CircleAvatar(
                    radius: 13.w,
                    backgroundColor: Colors.green.shade100,
                    child: Icon(
                      Icons.check_outlined,
                      color: Colors.green,
                      size: 10.w,
                    ),
                  ),
                ),
                Gap(2.h),
                Center(
                  child: Text(
                    "Réservation confirmée",
                    style: TextStyle(
                      color: appColorText,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Numéro de réservation",
                            style: TextStyle(
                              color: appColorText,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "#AR910376",
                            style: TextStyle(
                              color: appColorTextThree,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      Gap(2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Coiffeuse",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "Amina Diallo",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Gap(1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Service",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "Tresses Africaines",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Gap(1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "11/09/2025",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Gap(1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Heure",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "10h:00",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Gap(1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total payé",
                            style: TextStyle(
                              color: appColorText,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "17 250 FCFA",
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
                              "Instructions importantes",
                              style: TextStyle(
                                color: appColorText,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Veuillez arriver 10 minutes avant "
                              "votre rendez-vous. La coiffeuse vous "
                              "contactera 24h avant pour confirmer.",
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
                Gap(2.h),
                CancelButton(
                  "Retour à l'accueil",
                  onPressed: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MenuPage()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

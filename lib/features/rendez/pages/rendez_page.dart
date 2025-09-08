import 'package:afrolia/core/themes/themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/widgets/widgets.dart';

class RendezPage extends StatefulWidget {
  const RendezPage({super.key});

  @override
  State<RendezPage> createState() => _RendezPageState();
}

class _RendezPageState extends State<RendezPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: appColorWhite,
                          borderRadius: BorderRadius.circular(3.w),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "3",
                              style: TextStyle(
                                color: appColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Terminés",
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(2.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: appColorWhite,
                          borderRadius: BorderRadius.circular(3.w),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "1",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "A venir",
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(2.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: appColorWhite,
                          borderRadius: BorderRadius.circular(3.w),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "2",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "5 étoiles",
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(2.h),
                SubmitButtonIcon(
                  AppConstants.btnNew,
                  icone: Icon(Icons.add, color: appColorWhite),
                  onPressed: () async {},
                ),
                Gap(2.h),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 2.w),
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: appColorWhite,
                        borderRadius: BorderRadius.circular(3.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
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
                                        Text(
                                          "Tresses Africaines",
                                          style: TextStyle(
                                            color: appColorBlack,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(2.w),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withValues(alpha: .2),
                                        borderRadius: BorderRadius.circular(10.w),
                                      ),
                                      child: Text(
                                        "Terminé",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
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
                                              color: appColorBlack,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " 08/08/2025",
                                            style: TextStyle(fontSize: 15.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gap(4.w),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.access_time_outlined,
                                              size: 16,
                                              color: appColorBlack,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " 14h:00",
                                            style: TextStyle(fontSize: 15.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
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
                                    Text(
                                      "17 250 FCFA",
                                      style: TextStyle(
                                        color: appColorTextSecond,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Ma note:",
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                      TextSpan(
                                        text: " 5",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(1.h),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "#AR001523  ",
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                      TextSpan(
                                        text: " Réserver à nouveau",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: appColorTextSecond,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text("Réserver à nouveau cliqué ✅"),
                                              ),
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

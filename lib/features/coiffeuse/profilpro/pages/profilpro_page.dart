import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class ProfilproPage extends StatefulWidget {
  const ProfilproPage({super.key});

  @override
  State<ProfilproPage> createState() => _ProfilproPageState();
}

class _ProfilproPageState extends State<ProfilproPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(3.w),
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 2.w),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: appColorWhite,
                borderRadius: BorderRadius.circular(3.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 6,
                  ),
                ],
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
                          height: 10.h,
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
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "4.9",
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  TextSpan(
                                    text: " (127 avis)",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              "Membre depuis Septembre 2025",
                              style: TextStyle(
                                color: appColorTextSecond,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Gap(1.h),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Modifier la photo",
                                style: TextStyle(
                                  color: appColorTextSecond,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "127",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: appColorTextSecond,
                            ),
                          ),
                          Text(
                            "Clientes",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                              color: appColorBlack,
                            ),
                          ),
                        ],
                      ),
                      Gap(3.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "5 ans",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: appColorTextSecond,
                            ),
                          ),
                          Text(
                            "Expérience",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                              color: appColorBlack,
                            ),
                          ),
                        ],
                      ),
                      Gap(3.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "98%",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: appColorTextSecond,
                            ),
                          ),
                          Text(
                            "Satisfaction",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                              color: appColorBlack,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(2.h),
                  SubmitButton(
                    fontSize: 16.sp,
                    AppConstants.btnEditInfo,
                    onPressed: () async {},
                  ),
                ],
              ),
            ),
            Gap(2.h),
            Container(
              margin: EdgeInsets.only(bottom: 2.w),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: appColorWhite,
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: ListTile(
                onTap: () {},
                leading: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColorBorder,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Icon(
                    Icons.event_available_outlined,
                    color: appColorTextSecond,
                  ),
                ),
                title: Text(
                  "Gérer mes disponibilités",
                  style: TextStyle(
                    color: appColorText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_outlined,
                  color: appColorTextSecond,
                  size: 16.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 2.w),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: appColorWhite,
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: ListTile(
                onTap: () {},
                leading: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColorBorder,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Icon(
                    Icons.sell_outlined,
                    color: appColorTextSecond,
                  ),
                ),
                title: Text(
                  "Mes tarifs et services",
                  style: TextStyle(
                    color: appColorText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_outlined,
                  color: appColorTextSecond,
                  size: 16.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 2.w),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: appColorWhite,
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: ListTile(
                onTap: () {},
                leading: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColorBorder,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Icon(
                    Icons.credit_card_outlined,
                    color: appColorTextSecond,
                  ),
                ),
                title: Text(
                  "Méthodes de paiement",
                  style: TextStyle(
                    color: appColorText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_outlined,
                  color: appColorTextSecond,
                  size: 16.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 2.w),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: appColorWhite,
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: ListTile(
                onTap: () {},
                leading: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColorBorder,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Icon(
                    Icons.image_outlined,
                    color: appColorTextSecond,
                  ),
                ),
                title: Text(
                  "Ma galerie photos",
                  style: TextStyle(
                    color: appColorText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_outlined,
                  color: appColorTextSecond,
                  size: 16.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 2.w),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: appColorWhite,
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: ListTile(
                onTap: () {},
                leading: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColorBorder,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Icon(
                    Icons.help_outline_outlined,
                    color: appColorTextSecond,
                  ),
                ),
                title: Text(
                  "Aide & support",
                  style: TextStyle(
                    color: appColorText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_outlined,
                  color: appColorTextSecond,
                  size: 16.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 2.w),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: appColorWhite,
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: ListTile(
                onTap: () {},
                leading: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColorBorder,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Icon(
                    Icons.beenhere_outlined,
                    color: appColorTextSecond,
                  ),
                ),
                title: Text(
                  "Confidentialité",
                  style: TextStyle(
                    color: appColorText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_outlined,
                  color: appColorTextSecond,
                  size: 16.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 2.w),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: appColorWhite,
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: ListTile(
                onTap: () {},
                leading: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: .2),
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Icon(Icons.logout_outlined, color: Colors.red),
                ),
                title: Text(
                  "Se déconnecter",
                  style: TextStyle(
                    color: appColorText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_outlined,
                  color: Colors.red,
                  size: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

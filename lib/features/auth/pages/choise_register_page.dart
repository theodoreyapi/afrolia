import 'package:afrolia/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../core/themes/themes.dart';

class ChoiseRegisterPage extends StatefulWidget {
  const ChoiseRegisterPage({super.key});

  @override
  State<ChoiseRegisterPage> createState() => _ChoiseRegisterPageState();
}

class _ChoiseRegisterPageState extends State<ChoiseRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    "Inscription",
                    style: TextStyle(
                      color: appColorText,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                "Choisissez votre profil",
                style: TextStyle(
                  color: appColorText,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Quel type de compte souhaitez-vous créer?",
                style: TextStyle(
                  color: appColorTextSecond,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Gap(4.h),
              Container(
                decoration: BoxDecoration(
                  color: appColorWhite,
                  borderRadius: BorderRadius.circular(3.w),
                  border: Border.all(color: appColorBorder, width: 2),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(3.w),
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => RegisterPage(texte: "Cliente")));
                  },
                  title: Text(
                    "Cliente",
                    style: TextStyle(
                      color: appColorText,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Je veux réserver des coiffeuses",
                    style: TextStyle(
                      color: appColorTextSecond,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
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
                    child: Icon(Icons.person_4_outlined, color: appColorWhite),
                  ),
                ),
              ),
              Gap(2.h),
              Container(
                decoration: BoxDecoration(
                  color: appColorWhite,
                  borderRadius: BorderRadius.circular(3.w),
                  border: Border.all(color: appColorBorder, width: 2),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(3.w),
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => RegisterPage(texte: "Coiffeuse")));
                  },
                  title: Text(
                    "Coiffeuse",
                    style: TextStyle(
                      color: appColorText,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Je propose mes services",
                    style: TextStyle(
                      color: appColorTextSecond,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
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
                    child: Icon(
                      Icons.content_cut_outlined,
                      color: appColorWhite,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:afrolia/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'info_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(3.w),
          children: [
            Container(
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
                    child: Image.asset("assets/images/gal2.jpg", height: 10.h),
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
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => InfoPage()),
                  );
                },
                leading: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColorBorder,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Icon(
                    Icons.person_4_outlined,
                    color: appColorTextSecond,
                  ),
                ),
                title: Text(
                  "Mes informations",
                  style: TextStyle(
                    color: appColorText,
                    fontSize: 18.sp,
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
                    fontSize: 18.sp,
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
                    fontSize: 18.sp,
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
                    fontSize: 18.sp,
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

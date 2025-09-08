import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/auth.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  String selectedLang = "fr";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => checkLogin());
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? role = pref.getString("role");
    if (role != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Container()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(2.h),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedLang = "fr";
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedLang == "fr"
                                  ? const Color(0xFFCC6A00)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(3.w),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 16,
                            ),
                            child: Text(
                              "Français",
                              style: GoogleFonts.poppins(
                                color: selectedLang == "fr"
                                    ? appColorWhite
                                    : appColorBlack,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Gap(2.w),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedLang = "en";
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedLang == "en"
                                  ? const Color(0xFFCC6A00)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(3.w),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 16,
                            ),
                            child: Text(
                              "English",
                              style: GoogleFonts.poppins(
                                color: selectedLang == "en"
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(4.h),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.w),
                    gradient: LinearGradient(
                      colors: [appColorOrange, appColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3.w),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Image.asset(
                        "assets/images/splash.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Gap(1.h),
                Text(
                  AppConstants.appName,
                  style: GoogleFonts.pacifico(
                    color: appColorText,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                Gap(1.h),
                Text(
                  selectedLang == "fr"
                      ? "La coiffure Afro à portée de main"
                      : "Afro hairstyle at your fingertips",
                  style: TextStyle(
                    color: appColorText,
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Gap(3.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3.w),
                  child: Image.asset(
                    "assets/images/splash.jpg",
                    height: 20.h,
                    width: 100.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Gap(2.h),
                Text(
                  selectedLang == "fr"
                      ? "Trouvez la coiffeuse parfaite près de chez vous et réservez votre rendez-vous en quelques clics"
                      : "Find the perfect hairstylist near you and book your appointment in just a few clicks",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: appColorTextSecond,
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Gap(2.h),
                SubmitButton(
                  AppConstants.btnRegister,
                  onPressed: () async {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => ChoiseRegisterPage()));
                  },
                ),
                Gap(1.h),
                CancelButton(
                  AppConstants.btnLogin,
                  onPressed: () async {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => LoginPage()));
                  },
                ),
                Gap(2.h),
                Text(
                  selectedLang == "fr"
                      ? "Rejoignez notre communauté de coiffeuses professionnelles"
                      : "Join our community of professional hairdressers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: appColorTextThree,
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

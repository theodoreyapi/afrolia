import 'package:afrolia/features/coiffeuse/menupro/pages/menupro_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../menu/menu.dart';
import 'intro_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double loadingValue = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      _updateLoadingProgress();
    });
  }

  _updateLoadingProgress() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (loadingValue >= 1) {
        _navigateToNextScreen();
        return;
      }
      loadingValue += 0.1;
      setState(() {});
      _updateLoadingProgress();
    });
  }

  Future<void> _navigateToNextScreen() async {
    String? role = SharedPreferencesHelper().getString('role');
    print(role);
    if (role != null) {
      if (role == 'hair') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MenuproPage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MenuPage()),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const IntroPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      extendBody: true,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppConstants.appName,
              style: GoogleFonts.pacifico(
                color: appColorText,
                fontSize: 32.sp,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              "La coiffure Afro à portée de main",
              style: TextStyle(
                color: appColorText,
                fontSize: 16.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

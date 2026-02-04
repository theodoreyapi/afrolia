import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'core/constants/constants.dart';
import 'core/themes/themes.dart';
import 'core/utils/sessions.dart';
import 'features/splash/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesHelper().init();

  Stripe.publishableKey = "pk_live_51SA8qc2fmgPoYZOHW0np4yS2VHmjYv3FOzHjka5Z8AA4oyvAXD8vOb0kn7Cjoc5ZYI3zEuwpPgj1gBL5GJPICFow00kIjwA5tr";
  await Stripe.instance.applySettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: appColor),
            textTheme: GoogleFonts.ptSerifTextTheme(),
            useMaterial3: true,
          ),
          home: SplashPage(),
        );
      },
    );
  }
}

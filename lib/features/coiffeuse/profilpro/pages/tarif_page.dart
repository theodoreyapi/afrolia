import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:afrolia/features/coiffeuse/profilpro/pages/service_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class TarifPage extends StatefulWidget {
  const TarifPage({super.key});

  @override
  State<TarifPage> createState() => _TarifPageState();
}

class _TarifPageState extends State<TarifPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                    "Mes Services & Tarifs",
                    style: TextStyle(
                      color: appColorText,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Gap(4.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(7.w),
        child: SubmitButton(
          AppConstants.btnCreateService,
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServicePage()),
            );
          },
        ),
      ),
    );
  }
}

import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/features/coiffeuse/apercu/apercu.dart';
import 'package:afrolia/features/coiffeuse/reservation/reservation.dart';
import 'package:afrolia/features/coiffeuse/revenu/revenu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/sessions.dart';
import '../../../menu/pages/menu_page.dart';
import '../../profilpro/profilepro.dart';

class MenuproPage extends StatefulWidget {
  const MenuproPage({super.key});

  @override
  State<MenuproPage> createState() => _MenuproPageState();
}

class _MenuproPageState extends State<MenuproPage> {
  int currentPageIndex = 0;

  final Widget _home = ApercuPage();
  final Widget _invite = ReservationPage();
  final Widget _chat = RevenuPage();
  final Widget _profile = ProfilproPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(1.w),
          child: ClipOval(
            child: Image.network(
              SharedPreferencesHelper().getString('photo')!,
              height: 10.h,
              width: 10.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                  height: 10.h,
                  width: 10.h,
                );
              },
            ),
          ),
        ),
        backgroundColor: appColorWhite,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          AppConstants.appName,
          style: GoogleFonts.pacifico(
            color: appColorText,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MenuPage()),
                (route) => false,
              );
            },
            child: Padding(
              padding: EdgeInsets.all(1.w),
              child: CircleAvatar(
                child: Icon(
                  Icons.flip_camera_android_outlined,
                  color: appColorText,
                ),
              ),
            ),
          ),
        ],
      ),

      /// Body
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: getBody(),
      ),

      /// Navigation bar
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        surfaceTintColor: appColor,
        indicatorColor: appColor.withValues(alpha: 0.15),
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: [
          _buildNavItem(Icons.dashboard_outlined, "Aperçu", 0),
          _buildNavItem(Icons.event_available_outlined, "Réservations", 1),
          _buildNavItem(Icons.monetization_on_outlined, "Revenus", 2),
          _buildNavItem(Icons.person_outline, "Profil", 3),
        ],
      ),
    );
  }

  NavigationDestination _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentPageIndex == index;
    return NavigationDestination(
      icon: Icon(
        icon,
        color: isSelected ? appColor : appColorBlack.withValues(alpha: 0.5),
        size: 24,
      ),
      label: label,
    );
  }

  Widget getBody() {
    if (currentPageIndex == 0) {
      return _home;
    } else if (currentPageIndex == 1) {
      return _invite;
    } else if (currentPageIndex == 2) {
      return _chat;
    } else {
      return _profile;
    }
  }
}

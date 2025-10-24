import 'package:afrolia/features/coiffeuse/menupro/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/sessions.dart';
import '../../favorite/favorite.dart';
import '../../profile/profile.dart';
import '../../rendez/rendez.dart';
import '../../search/search.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentPageIndex = 0;

  final Widget _home = RendezPage();
  final Widget _invite = SearchPage();
  final Widget _chat = FavoritePage();
  final Widget _profile = ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(1.w),
          child: ClipOval(
            child: SharedPreferencesHelper().getString('photo') == ""
                ? Image.asset("assets/images/logo.png")
                : Image.network(SharedPreferencesHelper().getString('photo')!),
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
                MaterialPageRoute(builder: (context) => MenuproPage()),
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
          _buildNavItem(Icons.home_outlined, "Rendez-vous", 0),
          _buildNavItem(Icons.search_outlined, "Recherche", 1),
          _buildNavItem(Icons.favorite_outline, "Favorites", 2),
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

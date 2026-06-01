import 'package:afrolia/features/auth/auth.dart';
import 'package:afrolia/features/coiffeuse/menupro/pages/pages.dart';
import 'package:afrolia/features/product/pages/cart_product_page.dart';
import 'package:afrolia/features/product/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
  final Widget _product = ProductPage();
  final Widget _chat = FavoritePage();
  final Widget _profile = ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(1.w),
          child: ClipOval(
            child: (() {
              final photo = SharedPreferencesHelper().getString('photo');

              if (photo == null || photo.isEmpty) {
                return Image.asset("assets/images/logo.png", fit: BoxFit.cover);
              }

              return Image.network(
                photo,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.cover,
                  );
                },
              );
            })(),
          ),
        ),
        backgroundColor: appColorWhite,
        elevation: 0.5,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppConstants.appName,
              style: GoogleFonts.pacifico(
                color: currentPageIndex == 2
                    ? appColorProduct
                    : appColorText,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
            if (currentPageIndex == 2) ...[
              Gap(1.w),
              Text(
                "Boutique",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ],
        ),
        actions: [
          if (currentPageIndex == 2)
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CartProductPage()),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(1.w),
                child: CircleAvatar(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: appColorText,
                  ),
                ),
              ),
            ),
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
        surfaceTintColor: Colors.white,
        indicatorColor: currentPageIndex == 2
            ? appColorProduct.withValues(alpha: 0.12)
            : appColor.withValues(alpha: 0.12),
        selectedIndex: currentPageIndex,

        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              color: currentPageIndex == 2 ? appColorProduct : appColor,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            );
          }

          return TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
          );
        }),

        onDestinationSelected: (int index) {
          // Recherche + Boutique accessibles sans connexion
          if (index == 0 || index == 2) {
            setState(() {
              currentPageIndex = index;
            });
            return;
          }

          // Vérification connexion
          final phone = SharedPreferencesHelper().getString('phone');

          if (phone == null || phone.isEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
            return;
          }

          setState(() {
            currentPageIndex = index;
          });
        },

        destinations: [
          _buildNavItem(Icons.search_outlined, "Recherche", 0),
          _buildNavItem(Icons.home_outlined, "Rendez-vous", 1),
          _buildNavItem(Icons.local_mall_outlined, "Boutique", 2),
          _buildNavItem(Icons.favorite_outline, "Favorites", 3),
          _buildNavItem(Icons.person_outline, "Profil", 4),
        ],
      ),
    );
  }

  NavigationDestination _buildNavItem(IconData icon, String label, int index) {
    return NavigationDestination(
      icon: Icon(icon, color: Colors.grey, size: 24),

      selectedIcon: Icon(
        icon,
        color: currentPageIndex == 2 ? appColorProduct : appColor,
        size: 26,
      ),

      label: label,
    );
  }

  Widget getBody() {
    if (currentPageIndex == 0) {
      return _invite;
    } else if (currentPageIndex == 1) {
      return _home;
    } else if (currentPageIndex == 2) {
      return _product;
    } else if (currentPageIndex == 3) {
      return _chat;
    } else {
      return _profile;
    }
  }
}

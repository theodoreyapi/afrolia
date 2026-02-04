import 'package:afrolia/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../../auth/auth.dart';
import 'info_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? formattedDate;

  @override
  void initState() {
    super.initState();
    _loadDate();
  }

  Future<void> _loadDate() async {
    await initializeDateFormatting('fr_FR');

    final creationString = SharedPreferencesHelper().getString('creation');
    if (creationString != null) {
      final dateReserve = DateTime.parse(creationString);

      final formatted = DateFormat("MMMM yyyy", 'fr_FR').format(dateReserve);

      setState(() {
        formattedDate = formatted[0].toUpperCase() + formatted.substring(1);
      });
    }
  }

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
                    child: Image.network(
                      SharedPreferencesHelper().getString('photo')!,
                      height: 10.h,
                      width: 10.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/logo.png",
                          height: 10.h,
                          width: 10.h,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Gap(2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${SharedPreferencesHelper().getString('nom')!} "
                                  "${SharedPreferencesHelper().getString('prenom')!}"
                              .toUpperCase(),
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
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          color: appColorWhite,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, -3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Barre de glissement
                            Container(
                              width: 40,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            Gap(3.h),

                            // Icône expressive
                            Container(
                              decoration: BoxDecoration(
                                color: appColor.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(3.w),
                              child: Icon(
                                Icons.logout_rounded,
                                color: appColor,
                                size: 40,
                              ),
                            ),

                            Gap(2.h),

                            // Titre
                            Text(
                              "Se déconnecter ?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Gap(1.h),

                            // Texte explicatif
                            Text(
                              "Vous êtes sur le point de vous déconnecter.\n"
                              "Vous n’aurez plus accès à vos informations tant que vous ne serez pas reconnecté.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14.sp,
                                height: 1.5,
                              ),
                            ),

                            Gap(3.h),

                            // Bloc d'information
                            Container(
                              padding: EdgeInsets.all(3.w),
                              decoration: BoxDecoration(
                                color: appColor.withValues(alpha: .08),
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: appColor,
                                    size: 22,
                                  ),
                                  Gap(2.w),
                                  Expanded(
                                    child: Text(
                                      "Vous pourrez vous reconnecter à tout moment avec vos identifiants habituels.",
                                      style: TextStyle(
                                        color: appColor,
                                        fontSize: 14.sp,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Gap(3.h),

                            // Boutons d’action
                            Row(
                              children: [
                                Expanded(
                                  child: CancelButton(
                                    "Annuler",
                                    height: 10.w,
                                    fontSize: 15.sp,
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                                Gap(3.w),
                                Expanded(
                                  child: SubmitButton(
                                    "Se déconnecter",
                                    height: 10.w,
                                    fontSize: 15.sp,
                                    couleur: appColor,
                                    // 👈 Ton thème principal, pas rouge
                                    onPressed: () async {
                                      await SharedPreferencesHelper().clear();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),

                            Gap(1.h),
                          ],
                        ),
                      );
                    },
                  );
                },
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
                    color: Colors.red,
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
            Gap(2.h),
            Container(
              color: Colors.grey[200],
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(2.h),
              child: FutureBuilder(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    final info = snapshot.data as PackageInfo;
                    return Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              info.appName,
                              style: GoogleFonts.pacifico(
                                color: appColorText,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              'Version: ${info.version}',
                              style: TextStyle(
                                color: appColorBlack,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return Container(
                                  padding: EdgeInsets.all(5.w),
                                  decoration: BoxDecoration(
                                    color: appColorWhite,
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(25),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.1,
                                        ),
                                        blurRadius: 10,
                                        offset: const Offset(0, -3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Barre de glissement
                                      Container(
                                        width: 40,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                      ),
                                      Gap(3.h),

                                      // Icône principale
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(
                                            alpha: 0.1,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        padding: EdgeInsets.all(3.w),
                                        child: const Icon(
                                          Icons.warning_amber_rounded,
                                          color: Colors.red,
                                          size: 45,
                                        ),
                                      ),

                                      Gap(2.h),

                                      // Titre clair
                                      Text(
                                        "Supprimer votre compte ?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      Gap(1.h),

                                      // Texte explicatif humain
                                      Text(
                                        "Cette action est définitive.\nVotre profil, vos données et toutes vos informations seront définitivement supprimés de l’application.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 14.sp,
                                          height: 1.5,
                                        ),
                                      ),

                                      Gap(3.h),

                                      // Bloc d'information douce
                                      Container(
                                        padding: EdgeInsets.all(3.w),
                                        decoration: BoxDecoration(
                                          color: appColor.withValues(
                                            alpha: .08,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            3.w,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.info_outline,
                                              color: appColor,
                                              size: 22,
                                            ),
                                            Gap(2.w),
                                            Expanded(
                                              child: Text(
                                                "Nous vous conseillons de sauvegarder vos données importantes avant de poursuivre cette suppression.",
                                                style: TextStyle(
                                                  color: appColor,
                                                  fontSize: 14.sp,
                                                  height: 1.4,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Gap(3.h),

                                      // Boutons d'action
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CancelButton(
                                              "Annuler",
                                              height: 10.w,
                                              fontSize: 15.sp,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ),
                                          Gap(3.w),
                                          Expanded(
                                            child: SubmitButton(
                                              "Supprimer le compte",
                                              height: 10.w,
                                              fontSize: 14.sp,
                                              couleur: Colors.red,
                                              onPressed: () async {
                                                /*// 🧩 Exemple : à adapter selon ton API
                                                await deleteUserAccount();
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => const LoginPage()),
                                                      (route) => false,
                                                );*/
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      Gap(1.h),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

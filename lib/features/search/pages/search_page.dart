import 'dart:convert';

import 'package:afrolia/features/search/search.dart';
import 'package:afrolia/models/user/salons/salon_model.dart';
import 'package:flutter/material.dart';

import 'package:afrolia/core/themes/themes.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/widgets.dart';
import 'detail_search_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var search = TextEditingController();

  List<SalonModel> allSalons = [];
  bool isLoading = false;
  late Future<List<SalonModel>> _futureSalons;

  @override
  void initState() {
    super.initState();
    _futureSalons = fetchSalons();
  }

  void _refreshData() {
    setState(() {
      _futureSalons = fetchSalons();
    });
  }

  Future<List<SalonModel>> fetchSalons() async {
    final http.Response response = await http.get(
      Uri.parse(ApiUrls.getListSalon),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(
        utf8.decode(response.bodyBytes),
      );

      final List<dynamic> contentList = jsonResponse['data'];

      List<SalonModel> medicaments = contentList
          .map((item) => SalonModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return medicaments;
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Column(
            children: [
              InputText(
                hintText: "Rechercher par nom ou spécialité...",
                keyboardType: TextInputType.text,
                controller: search,
                prefixIcon: Icon(Icons.search_outlined),
                validatorMessage: "Veuillez saisir un mot",
              ),
              Gap(2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "6 coiffeuses trouvés",
                      style: TextStyle(
                        color: appColorText,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Gap(2.w),
                  FloatingActionButton.small(
                    elevation: 0,
                    heroTag: "map",
                    shape: CircleBorder(),
                    backgroundColor: appColorBorder,
                    onPressed: () {},
                    child: Icon(Icons.map_outlined, color: appColorText),
                  ),
                ],
              ),
              Gap(2.h),
              Expanded(
                child: FutureBuilder<List<SalonModel>>(
                  future: _futureSalons,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Impossible d'avoir la liste des salons. "
                          "Verifiez votre internet. Si le problème "
                          "persiste veuillez contactez AFROLIA",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      allSalons = snapshot.data!;

                      if (allSalons.isEmpty) {
                        return Center(child: Text("Pas de salon disponible"));
                      }

                      return ListView.builder(
                        itemCount: allSalons.length,
                        itemBuilder: (context, index) {
                          final salon = allSalons[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailSearchPage(salon: salon),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 2.w),
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              3.w,
                                            ),
                                            child: Image.network(
                                              salon.photo!,
                                              height: 8.h,
                                              width: 8.h,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    return Image.asset(
                                                      "assets/images/logo.png",
                                                      fit: BoxFit.cover,
                                                      height: 8.h,
                                                      width: 8.h,
                                                    );
                                                  },
                                            ),
                                          ),
                                          Positioned(
                                            top: -5,
                                            right: -5,
                                            child: CircleAvatar(
                                              radius: 3.w,
                                              backgroundColor:
                                                  Colors.blueAccent,
                                              child: Icon(
                                                Icons.check_circle_rounded,
                                                size: 4.w,
                                                color: appColorWhite,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              salon.nomComplet!,
                                              style: TextStyle(
                                                color: appColorText,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: salon.note!
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        " (${salon.nombreAvis} avis)",
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Gap(1.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          size: 16,
                                                          color: appColorBlack,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: salon.commune,
                                                        style: TextStyle(
                                                          fontSize: 15.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Gap(2.w),
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: Icon(
                                                          Icons
                                                              .access_time_outlined,
                                                          size: 16,
                                                          color: appColorBlack,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            " ${salon.experience} ans d'exp.",
                                                        style: TextStyle(
                                                          fontSize: 15.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(1.h),
                                  salon.specialites != null &&
                                          salon.specialites!.isNotEmpty
                                      ? Wrap(
                                          spacing: 2.w,
                                          runSpacing: 1.h,
                                          children: salon.specialites!.map((
                                            specialite,
                                          ) {
                                            return Container(
                                              padding: EdgeInsets.all(2.w),
                                              decoration: BoxDecoration(
                                                color: appColorFond,
                                                borderRadius:
                                                    BorderRadius.circular(10.w),
                                              ),
                                              child: Text(
                                                specialite,
                                                style: TextStyle(
                                                  color: appColorText,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        )
                                      : SizedBox.shrink(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          salon.prixRange!,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: appColorTextSecond,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(1.w),
                                          decoration: BoxDecoration(
                                            color: salon.statut == "Disponible"
                                                ? Colors.green.withValues(
                                                    alpha: .2,
                                                  )
                                                : appColorOrange.withValues(
                                                    alpha: .2,
                                                  ),
                                            borderRadius: BorderRadius.circular(
                                              10.w,
                                            ),
                                          ),
                                          child: Text(
                                            salon.statut == "Disponible"
                                                ? "Disponible"
                                                : "Occupee",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color:
                                                  salon.statut == "Disponible"
                                                  ? Colors.green
                                                  : appColorOrange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Gap(1.w),
                                      Expanded(
                                        child: SubmitButton(
                                          fontSize: 15.sp,
                                          AppConstants.btnReserver,
                                          height: 4.h,
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ReservationPage(salon: salon),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: Text("Aucune donnée disponible"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'Refesh',
        tooltip: 'Actualiser la liste',
        backgroundColor: appColorText,
        onPressed: _refreshData,
        child: Icon(Icons.refresh, color: appColorWhite),
      ),
    );
  }
}

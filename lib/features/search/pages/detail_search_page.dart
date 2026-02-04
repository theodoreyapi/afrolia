import 'dart:convert';

import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:afrolia/features/search/search.dart';
import 'package:afrolia/models/hair/disponibilites/disponibilite_model.dart';
import 'package:afrolia/models/hair/services/service_model.dart';
import 'package:afrolia/models/user/salons/salon_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/utils.dart';

class DetailSearchPage extends StatefulWidget {
  SalonModel? salon;

  DetailSearchPage({super.key, this.salon});

  @override
  State<DetailSearchPage> createState() => _DetailSearchPageState();
}

class _DetailSearchPageState extends State<DetailSearchPage>
    with TickerProviderStateMixin {
  final formatterNumber = NumberFormat('#,###', 'fr_FR');

  List<ServiceModel> allMedicaments = [];
  bool isLoadings = false;
  late Future<List<ServiceModel>> _futureMedicaments;

  late final TabController _tabController;

  List<Map<String, dynamic>> images = [];
  bool isLoading = true;

  String? nom,
      note,
      photo,
      nombre,
      commune,
      experience,
      speciale,
      presentation,
      client,
      satisfaire = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _futureMedicaments = fetchMedicaments();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      infoPerso();
      fetchGallery();
      fetchDisponibilites();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ⚡ Récupération des images depuis l'API
  Future<void> fetchGallery() async {
    setState(() => isLoading = true);

    try {
      final uri = Uri.parse(
        "${ApiUrls.getListGallery}${widget.salon!.id}",
      ); // adapter userId
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          setState(() {
            images = List<Map<String, dynamic>>.from(data['data']);
          });
        } else {
          SnackbarHelper.showError(
            context,
            data['message'] ?? "Erreur inconnue",
          );
        }
      } else {
        SnackbarHelper.showError(
          context,
          "Erreur ${response.statusCode} lors de la récupération",
        );
      }
    } catch (e) {
      SnackbarHelper.showError(context, "Erreur de connexion : $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> infoPerso() async {
    final http.Response response = await http.get(
      Uri.parse("${ApiUrls.getProfileSalon}${widget.salon!.id}"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(
        utf8.decode(response.bodyBytes),
      );

      setState(() {
        photo = jsonResponse['data']['photo'];
        nom = jsonResponse['data']['nom_complet'];
        commune = jsonResponse['data']['localisation'];
        experience = jsonResponse['data']['experience'].toString();
        note = jsonResponse['data']['note'].toString();
        nombre = jsonResponse['data']['nombre_avis'].toString();
        speciale = jsonResponse['data']['specialites'];
        presentation = jsonResponse['data']['presentation'];
        client = jsonResponse['data']['statistiques']['clients'].toString();
        satisfaire = jsonResponse['data']['statistiques']['satisfaction'];
      });
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  Future<List<ServiceModel>> fetchMedicaments() async {
    final http.Response response = await http.get(
      Uri.parse("${ApiUrls.getListServices}${widget.salon!.id}"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(
        utf8.decode(response.bodyBytes),
      );

      final List<dynamic> contentList = jsonResponse['data'];

      List<ServiceModel> medicaments = contentList
          .map((item) => ServiceModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return medicaments;
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  Future<List<DisponibiliteModel>> fetchDisponibilites() async {
    final response = await http.get(
      Uri.parse("${ApiUrls.getListDisponibility}${widget.salon!.id}"),
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => DisponibiliteModel.fromJson(e)).toList();
    } else {
      throw Exception("Erreur de chargement des disponibilités");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(2.w),
          child: FloatingActionButton.small(
            elevation: 0,
            backgroundColor: appColorBorder,
            shape: CircleBorder(),
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_outlined, color: appColorTextSecond),
          ),
        ),
        title: Text(
          "Profil coiffeuse",
          style: TextStyle(color: appColorText, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: CircleAvatar(
              backgroundColor: Colors.purpleAccent.withValues(alpha: .2),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_outline, color: Colors.purpleAccent),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Column(
            children: [
              nom == null || nom == ""
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      margin: EdgeInsets.only(bottom: 2.w),
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: appColorWhite,
                        borderRadius: BorderRadius.circular(3.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3.w),
                                child: Image.network(
                                  photo!,
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
                              Gap(2.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      nom!,
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
                                            text: note!,
                                            style: TextStyle(fontSize: 15.sp),
                                          ),
                                          TextSpan(
                                            text: " ($nombre avis)",
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gap(1.h),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.location_on_outlined,
                                              size: 16,
                                              color: appColorBlack,
                                            ),
                                          ),
                                          TextSpan(
                                            text: commune!,
                                            style: TextStyle(fontSize: 15.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gap(1.h),
                                    Text(
                                      "$experience an(s) d'expérience . Spécialiste $speciale",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: appColorTextSecond,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Gap(1.h),
                          Text(
                            presentation!,
                            style: TextStyle(
                              color: appColorBlack,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                            ),
                          ),
                          Gap(2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    client!,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: appColorTextSecond,
                                    ),
                                  ),
                                  Text(
                                    "Clientes",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                      color: appColorBlack,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(3.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "$experience ans",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: appColorTextSecond,
                                    ),
                                  ),
                                  Text(
                                    "Expérience",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                      color: appColorBlack,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(3.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    satisfaire!,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: appColorTextSecond,
                                    ),
                                  ),
                                  Text(
                                    "Satisfaction",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                      color: appColorBlack,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(3.w),
                              Expanded(
                                child: SubmitButton(
                                  fontSize: 16.sp,
                                  AppConstants.btnReserver,
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReservationPage(
                                          salon: widget.salon,
                                        ),
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
              Gap(2.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.w),
                    color: appColor,
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: appColorText,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: "Galerie"),
                    Tab(text: "Tarifs"),
                    Tab(text: "Disponibilités"),
                  ],
                ),
              ),
              Gap(1.h),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(color: appColor),
                          )
                        : images.isEmpty
                        ? Center(
                            child: Text(
                              "Aucune image disponible.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: appColorTextSecond,
                              ),
                            ),
                          )
                        : GridView.builder(
                            itemCount: images.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 3.w,
                                  mainAxisSpacing: 3.w,
                                  childAspectRatio: 1,
                                ),
                            itemBuilder: (context, index) {
                              final image = images[index];
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(2.w),
                                child: Image.network(
                                  image['image'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: appColor,
                                          ),
                                        );
                                      },
                                  errorBuilder: (_, __, ___) => Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                    FutureBuilder<List<ServiceModel>>(
                      future: _futureMedicaments,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (isLoadings) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Impossible d'avoir la liste des tarifs. "
                              "Verifiez votre internet. Si le probleme "
                              "persiste veuillez contactez AFROLIA",
                              textAlign: TextAlign.center,
                            ),
                          );
                        }

                        if (snapshot.hasData) {
                          allMedicaments = snapshot.data!;

                          if (allMedicaments.isEmpty) {
                            return Center(
                              child: Text("Pas de tarif disponible"),
                            );
                          }

                          return ListView.builder(
                            itemCount: allMedicaments.length,
                            itemBuilder: (context, index) {
                              final medocs = allMedicaments[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 2.w),
                                padding: EdgeInsets.all(3.w),
                                decoration: BoxDecoration(
                                  color: appColorWhite,
                                  borderRadius: BorderRadius.circular(3.w),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      medocs.specialite!.libelle!,
                                      style: TextStyle(
                                        color: appColorText,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      medocs.description!,
                                      style: TextStyle(
                                        color: appColorBlack,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Gap(1.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${formatterNumber.format(medocs.prix)} FCFA",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: appColorTextThree,
                                          ),
                                        ),
                                        Gap(2.w),
                                        Expanded(
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.access_time_outlined,
                                                    size: 16,
                                                    color: appColorBlack,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "${medocs.minute}min",
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return Center(child: Text("Aucune donnée disponible"));
                      },
                    ),
                    FutureBuilder<List<DisponibiliteModel>>(
                      future: fetchDisponibilites(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Erreur lors du chargement"),
                          );
                        }

                        final disponibilites = snapshot.data ?? [];

                        return ListView.builder(
                          itemCount: disponibilites.length,
                          itemBuilder: (context, index) {
                            final item = disponibilites[index];

                            return Container(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// 🟢 Jour ("Lundi", "Mercredi", etc.)
                                  Text(
                                    item.jour ?? "",
                                    style: TextStyle(
                                      color: appColorText,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 2.h),

                                  /// 🟢 Liste des heures (Wrap = affiche en lignes)
                                  Wrap(
                                    spacing: 2.w,
                                    runSpacing: 1.h,
                                    children: item.heures!.map((heure) {
                                      return Container(
                                        padding: EdgeInsets.all(2.w),
                                        decoration: BoxDecoration(
                                          color: appColorFond,
                                          borderRadius: BorderRadius.circular(
                                            3.w,
                                          ),
                                          border: Border.all(
                                            width: 2,
                                            color: appColorBorder,
                                          ),
                                        ),
                                        child: Text(
                                          heure,
                                          style: TextStyle(
                                            color: appColorText,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(5.w),
        child: SubmitButtonIcon(
          AppConstants.btnReserverM,
          icone: Icon(
            Icons.event_available_outlined,
            color: appColorWhite,
            size: 18.sp,
          ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReservationPage(salon: widget.salon),
              ),
            );
          },
        ),
      ),
    );
  }
}

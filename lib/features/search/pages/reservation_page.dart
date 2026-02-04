import 'dart:convert';

import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/features/search/search.dart';
import 'package:afrolia/models/hair/services/service_model.dart';
import 'package:afrolia/models/user/salons/salon_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';

class ReservationPage extends StatefulWidget {
  SalonModel? salon;

  ReservationPage({super.key, this.salon});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final formatterNumber = NumberFormat('#,###', 'fr_FR');

  List<ServiceModel> allServices = [];
  bool isLoadings = false;
  late Future<List<ServiceModel>> _futureMedicaments;

  @override
  void initState() {
    super.initState();
    _futureMedicaments = fetchMedicaments();
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
          "Choisir le service",
          style: TextStyle(color: appColorText, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: CircleAvatar(
              backgroundColor: appColorBorder,
              child: Text(
                "1/4",
                style: TextStyle(
                  color: appColorText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 2.w),
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: appColorWhite,
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3.w),
                          child: Image.network(
                            widget.salon!.photo!,
                            height: 7.h,
                            width: 7.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/logo.png",
                                fit: BoxFit.cover,
                                height: 7.h,
                                width: 7.h,
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
                                widget.salon!.nomComplet!,
                                style: TextStyle(
                                  color: appColorText,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
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
                                      text: widget.salon!.commune!,
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                  ],
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
              Text(
                "Choisissez votre service",
                style: TextStyle(
                  color: appColorText,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: FutureBuilder<List<ServiceModel>>(
                  future: _futureMedicaments,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (isLoadings) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Impossible d'avoir la liste des services. "
                          "Verifiez votre internet. Si le probleme "
                          "persiste veuillez contactez AFROLIA",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      allServices = snapshot.data!;

                      if (allServices.isEmpty) {
                        return Center(child: Text("Pas de service disponible"));
                      }

                      return ListView.builder(
                        itemCount: allServices.length,
                        itemBuilder: (context, index) {
                          final service = allServices[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DatePage(
                                    service: service,
                                    salon: widget.salon,
                                  ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.specialite!.libelle!,
                                    style: TextStyle(
                                      color: appColorText,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    service.description!,
                                    style: TextStyle(
                                      color: appColorBlack,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Gap(1.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${formatterNumber.format(service.prix)} FCFA",
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
                                                text:
                                                    " ${service.minute! ~/ 60}h "
                                                    "${service.minute! % 60}min",
                                                style: TextStyle(fontSize: 15.sp),
                                              ),
                                            ],
                                          ),
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
    );
  }
}

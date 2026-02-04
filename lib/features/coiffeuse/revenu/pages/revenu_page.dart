import 'dart:convert';

import 'package:afrolia/core/themes/themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';

class RevenuPage extends StatefulWidget {
  const RevenuPage({super.key});

  @override
  State<RevenuPage> createState() => _RevenuPageState();
}

class Service {
  final String name;
  final int reservation;
  final int price;

  Service({required this.name, required this.reservation, required this.price});
}

class _RevenuPageState extends State<RevenuPage> {
  String currentMonthYear = "";

  final List<Service> services = [
    Service(name: "Tresses Africaines", reservation: 45, price: 150000),
    Service(name: "Locks / Dreadlocks", reservation: 32, price: 250000),
    Service(name: "Tissage", reservation: 25, price: 200000),
    Service(name: "Coiffure Enfants", reservation: 38, price: 100000),
  ];

  List<String> mois = [];
  List<double> valeurs = [];

  @override
  void initState() {
    super.initState();

    initializeDateFormatting('fr_FR', null).then((_) {
      setState(() {
        currentMonthYear = DateFormat('MMMM yyyy', 'fr_FR').format(DateTime.now());
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      statistics();
      graphique();
    });
  }

  final formatter = NumberFormat('#,###');

  var moisencours = TextEditingController();
  var semaine = TextEditingController();
  var attente = TextEditingController();
  var total = TextEditingController();
  var jour = TextEditingController();
  var evolution = TextEditingController();

  var annee = TextEditingController();
  var total_annuel = TextEditingController();
  var croissance_estimee = TextEditingController();

  Future<void> statistics() async {
    final http.Response response = await http.get(
      Uri.parse(
        "${ApiUrls.getListGains}${SharedPreferencesHelper().getString('identifiant')}",
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(
        utf8.decode(response.bodyBytes),
      );

      setState(() {
        semaine.text = formatter.format(jsonResponse['data']['revenu_semaine']);
        moisencours.text = formatter.format(
          jsonResponse['data']['revenu_mois'],
        );
        attente.text = formatter.format(jsonResponse['data']['revenu_attente']);
        total.text = formatter.format(jsonResponse['data']['revenu_total']);
        jour.text = formatter.format(jsonResponse['data']['revenu_jour']);
        evolution.text = jsonResponse['data']['evolution_mois'].toString();
      });
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  Future<void> graphique() async {
    final http.Response response = await http.get(
      Uri.parse(
        "${ApiUrls.getEvolutionGains}${SharedPreferencesHelper().getString('identifiant')}",
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(
        utf8.decode(response.bodyBytes),
      );

      // Récupérer les données des revenus par mois
      List<dynamic> revenusParMois = jsonResponse['data']['revenus_par_mois'];

      setState(() {
        // Extraire les noms des mois (abrégés à 3 lettres)
        mois = revenusParMois.map((item) {
          String moisComplet = item['mois'] as String;
          return moisComplet.substring(0, 3); // Prend les 3 premières lettres
        }).toList();

        // Extraire les montants et les convertir en double
        valeurs = revenusParMois.map((item) {
          return (item['montant'] as num).toDouble();
        }).toList();

        // Les autres valeurs
        total_annuel.text = formatter.format(
          jsonResponse['data']['total_annuel'],
        );
        annee.text = jsonResponse['data']['annee'].toString();
        croissance_estimee.text = jsonResponse['data']['croissance_estimee']
            .toString();
      });

      // Pour debug - voir le résultat
      print("Mois: $mois");
      print("Valeurs: $valeurs");
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.w),
                    gradient: LinearGradient(
                      colors: [appColorOrange, appColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Revenus de $currentMonthYear",
                        style: TextStyle(
                          color: appColorWhite,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(2.h),
                      Text(
                        "${moisencours.text} FCFA",
                        style: TextStyle(
                          color: appColorWhite,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(2.h),
                      Text(
                        "vs mois dernier +${evolution.text}%",
                        style: TextStyle(
                          color: appColorWhite,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: appColorWhite,
                          borderRadius: BorderRadius.circular(3.w),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cette semaine",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              "${semaine.text} FCFA",
                              style: TextStyle(
                                color: appColorText,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(.5.h),
                            Text(
                              "Revenus hebdomadaires",
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(2.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: appColorWhite,
                          borderRadius: BorderRadius.circular(3.w),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Aujourd'hui",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              "${jour.text} FCFA",
                              style: TextStyle(
                                color: appColorText,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(.5.h),
                            Text(
                              "Revenus du jour",
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: appColorWhite,
                          borderRadius: BorderRadius.circular(3.w),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "En attente",
                              style: TextStyle(
                                color: appColorOrange,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              "${attente.text} FCFA",
                              style: TextStyle(
                                color: appColorText,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(.5.h),
                            Text(
                              "Paiement en attente",
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(2.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: appColorWhite,
                          borderRadius: BorderRadius.circular(3.w),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                color: appColorTextSecond,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              "${total.text} FCFA",
                              style: TextStyle(
                                color: appColorText,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(.5.h),
                            Text(
                              "Revenus totaux",
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(2.h),
                Container(
                  padding: EdgeInsets.all(3.w),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: appColorWhite,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Evolution des revenus ${annee.text}",
                        style: TextStyle(
                          color: appColorText,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(2.h),
                      SizedBox(
                        height: 300,
                        child: mois.isEmpty || valeurs.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : LineChart(
                                LineChartData(
                                  gridData: FlGridData(show: false),
                                  borderData: FlBorderData(show: false),
                                  titlesData: FlTitlesData(
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 50,
                                        getTitlesWidget: (value, meta) {
                                          // Formatter les montants en fonction de leur taille
                                          if (value >= 1000000) {
                                            return Text(
                                              "${(value / 1000000).toStringAsFixed(1)}M",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            );
                                          } else if (value >= 1000) {
                                            return Text(
                                              "${(value / 1000).toStringAsFixed(0)}k",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            );
                                          } else {
                                            return Text(
                                              "${value.toInt()}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 30,
                                        getTitlesWidget: (value, meta) {
                                          int index = value.toInt();
                                          if (index >= 0 &&
                                              index < mois.length) {
                                            return Text(
                                              mois[index],
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            );
                                          }
                                          return Container();
                                        },
                                      ),
                                    ),
                                  ),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: List.generate(
                                        valeurs.length,
                                        (i) => FlSpot(i.toDouble(), valeurs[i]),
                                      ),
                                      isCurved: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.orange,
                                          Colors.deepOrange,
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      barWidth: 4,
                                      isStrokeCapRound: true,
                                      dotData: FlDotData(show: true),
                                      belowBarData: BarAreaData(
                                        show: true,
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.orange.withValues(
                                              alpha: 0.3,
                                            ),
                                            Colors.transparent,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                  ],
                                  // Calculer automatiquement min et max en fonction des données
                                  minY: valeurs.isEmpty
                                      ? 0
                                      : valeurs.reduce(
                                              (a, b) => a < b ? a : b,
                                            ) *
                                            0.8,
                                  // 20% en dessous du min
                                  maxY: valeurs.isEmpty
                                      ? 100
                                      : valeurs.reduce(
                                              (a, b) => a > b ? a : b,
                                            ) *
                                            1.2, // 20% au-dessus du max
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Gap(2.h),
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColorWhite,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Revenus par service",
                        style: TextStyle(
                          color: appColorText,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(2.h),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          final service = services[index];
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              service.name,
                              style: TextStyle(
                                color: appColorText,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${service.reservation} réservations",
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            trailing: Text(
                              "${service.price} FCFA",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: appColorTextThree,
                              ),
                            ),
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
      ),
    );
  }
}

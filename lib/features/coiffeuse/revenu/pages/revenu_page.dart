import 'package:afrolia/core/themes/themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

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
  final List<Service> services = [
    Service(name: "Tresses Africaines", reservation: 45, price: 150000),
    Service(name: "Locks / Dreadlocks", reservation: 32, price: 250000),
    Service(name: "Tissage", reservation: 25, price: 200000),
    Service(name: "Coiffure Enfants", reservation: 38, price: 100000),
  ];

  final List<String> mois = ["Oct", "Nov", "Déc", "Jan", "Fév", "Mar"];
  final List<double> valeurs = [180, 165, 220, 198, 175, 245];

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
                        "Revenus de Septembre 2025",
                        style: TextStyle(
                          color: appColorWhite,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(2.h),
                      Text(
                        "245 000 FCFA",
                        style: TextStyle(
                          color: appColorWhite,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(2.h),
                      Text(
                        "vs mois dernier +23.7%",
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
                              "89 000 FCFA",
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
                              "23 000 FCFA",
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
                              "45 000 FCFA",
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
                              "1 900 000 FCFA",
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
                        "Evolution des revenus (cette année)",
                        style: TextStyle(
                          color: appColorText,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(2.h),
                      SizedBox(
                        height: 300,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text("${value.toInt()}k",
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500));
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  getTitlesWidget: (value, meta) {
                                    int index = value.toInt();
                                    if (index >= 0 && index < mois.length) {
                                      return Text(
                                        mois[index],
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
                                    valeurs.length, (i) => FlSpot(i.toDouble(), valeurs[i])),
                                isCurved: true, // courbe arrondie
                                gradient: LinearGradient(
                                  colors: [Colors.orange, Colors.deepOrange],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                barWidth: 4,
                                isStrokeCapRound: true,
                                dotData: FlDotData(show: true), // points visibles
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [Colors.orange.withOpacity(0.3), Colors.transparent],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ],
                            minY: 150, // valeur minimale sur Y
                            maxY: 260, // valeur max sur Y
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

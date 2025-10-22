import 'package:afrolia/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class ApercuPage extends StatefulWidget {
  const ApercuPage({super.key});

  @override
  State<ApercuPage> createState() => _ApercuPageState();
}

class Service {
  final String name;
  final int reservation;
  final int price;

  Service({required this.name, required this.reservation, required this.price});
}

class _ApercuPageState extends State<ApercuPage> {
  final List<Service> services = [
    Service(name: "Tresses Africaines", reservation: 45, price: 15000),
    Service(name: "Locks / Dreadlocks", reservation: 32, price: 25000),
    Service(name: "Tissage", reservation: 25, price: 20000),
    Service(name: "Coiffure Enfants", reservation: 38, price: 10000),
  ];

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
                            Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: .3),
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              child: Icon(
                                Icons.monetization_on_outlined,
                                color: Colors.green,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              "300 000 FCFA",
                              style: TextStyle(
                                color: appColorText,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(.5.h),
                            Text(
                              "Revenus ce mois",
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
                            Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: .3),
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              child: Icon(
                                Icons.event_available_outlined,
                                color: Colors.blue,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              "300 000 FCFA",
                              style: TextStyle(
                                color: appColorText,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(.5.h),
                            Text(
                              "Réservations",
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
                            Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: appColorBorder,
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              child: Icon(
                                Icons.star_outlined,
                                color: appColorTextSecond,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              "127",
                              style: TextStyle(
                                color: appColorText,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(.5.h),
                            Text(
                              "Clientes totales",
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
                            Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: appColorOrange.withValues(alpha: .3),
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              child: Icon(
                                Icons.access_time_outlined,
                                color: appColorTextThree,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              "30 000 FCFA",
                              style: TextStyle(
                                color: appColorText,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(.5.h),
                            Text(
                              "Revenus aujourdhui",
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
                  decoration: BoxDecoration(
                    color: appColorWhite,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Prochaine réservations",
                            style: TextStyle(
                              color: appColorText,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Voir tout",
                              style: TextStyle(
                                color: appColorTextThree,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(2.h),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 2.w),
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color: appColorFond,
                              borderRadius: BorderRadius.circular(3.w),
                            ),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    "assets/images/gal2.jpg",
                                    height: 6.h,
                                  ),
                                ),
                                Gap(2.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Sarah kone",
                                                style: TextStyle(
                                                  color: appColorText,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "Tresses Africaines",
                                                style: TextStyle(
                                                  color: appColorBlack,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              Text(
                                                "22/09/2025 à 14h:00",
                                                style: TextStyle(
                                                  color: appColorTextThree,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "17 250 FCFA",
                                                style: TextStyle(
                                                  color: appColorTextSecond,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(2.w),
                                                decoration: BoxDecoration(
                                                  color: index != 1
                                                      ? Colors.green.withValues(
                                                          alpha: .2,
                                                        )
                                                      : appColorBorder,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        10.w,
                                                      ),
                                                ),
                                                child: Text(
                                                  index != 1
                                                      ? "Confirmé"
                                                      : "En attente",
                                                  style: TextStyle(
                                                    color: index != 1
                                                        ? Colors.green
                                                        : appColorTextSecond,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
                        "Services populaires",
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
                            leading: Container(
                              padding: EdgeInsets.all(3.w),
                              decoration: BoxDecoration(
                                color: appColorBorder,
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              child: Text(
                                "#${index + 1}",
                                style: TextStyle(
                                  color: appColorTextSecond,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
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
                                fontSize: 15.sp,
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

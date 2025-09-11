import 'package:afrolia/core/themes/themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class Reservations {
  final String image;
  final String name;
  final String type;
  final String date;
  final String heure;
  final String telephone;
  final String code;
  final String statut;
  final int price;

  Reservations({
    required this.image,
    required this.name,
    required this.type,
    required this.date,
    required this.heure,
    required this.telephone,
    required this.code,
    required this.statut,
    required this.price,
  });
}

class _ReservationPageState extends State<ReservationPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  final List<Reservations> reservations = [
    Reservations(
      name: "Sara kone",
      price: 15000,
      image: 'assets/images/gal5.jpg',
      type: 'Tresses Africaines',
      date: '22/03/2024',
      heure: '14h:00',
      telephone: '+2250585831647',
      code: 'AR001567',
      statut: 'CONFIRME',
    ),
    Reservations(
      name: "Fatou diabate",
      price: 25000,
      image: 'assets/images/gal2.jpg',
      type: 'Tissage',
      date: '23/03/2024',
      heure: '15h:00',
      telephone: '+2250585831648',
      code: 'AR001568',
      statut: 'ATTENTE',
    ),
    Reservations(
      name: "Aicha traore",
      price: 10000,
      image: 'assets/images/gal3.jpg',
      type: 'Soin capillaire',
      date: '10/03/2024',
      heure: '12h:00',
      telephone: '+2250585831649',
      code: 'AR001569',
      statut: 'TERMINE',
    ),
    Reservations(
      name: "Kadi bamba",
      price: 30000,
      image: 'assets/images/gal4.jpg',
      type: 'Coupe afro',
      date: '22/03/2024',
      heure: '11h:00',
      telephone: '+2250585831650',
      code: 'AR001570',
      statut: 'CONFIRME',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  isScrollable: true,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.w),
                    color: appColor,
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  tabAlignment: TabAlignment.start,
                  labelColor: Colors.white,
                  unselectedLabelColor: appColorText,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: "Toutes (5)"),
                    Tab(text: "Confirmées (3)"),
                    Tab(text: "En attente (1)"),
                    Tab(text: "Terminées (1)"),
                  ],
                ),
              ),
              Gap(1.h),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      itemCount: reservations.length,
                      itemBuilder: (context, index) {
                        return buildReservationCard(reservations[index]);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReservationCard(Reservations reservation) {
    Color statutColor;
    Color statutBg;
    String statutLabel;

    switch (reservation.statut) {
      case "CONFIRME":
        statutColor = Colors.green;
        statutBg = Colors.green.withValues(alpha: 0.1);
        statutLabel = "Confirmé";
        break;
      case "ATTENTE":
        statutColor = Colors.orange;
        statutBg = Colors.orange.withValues(alpha: 0.1);
        statutLabel = "En attente";
        break;
      case "TERMINE":
        statutColor = Colors.blue;
        statutBg = Colors.blue.withValues(alpha: 0.1);
        statutLabel = "Terminé";
        break;
      default:
        statutColor = Colors.grey;
        statutBg = Colors.grey.withValues(alpha: 0.1);
        statutLabel = "Inconnu";
    }

    return Container(
      margin: EdgeInsets.only(bottom: 2.w),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: appColorWhite,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3.w),
            child: Image.asset(
              reservation.image,
              height: 7.h,
              width: 7.h,
              fit: BoxFit.cover,
            ),
          ),
          Gap(3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nom + statut
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reservation.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: appColorText,
                          ),
                        ),
                        Text(
                          reservation.type,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: statutBg,
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: Text(
                        statutLabel,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: statutColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(1.h),
                // Date + heure
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                    SizedBox(width: 1.w),
                    Text(reservation.date,style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),),
                    SizedBox(width: 4.w),
                    Icon(Icons.access_time, size: 16, color: Colors.black54),
                    SizedBox(width: 1.w),
                    Text(reservation.heure,style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),),
                  ],
                ),
                Gap(0.5.h),
                // Téléphone
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: Colors.black54),
                    SizedBox(width: 1.w),
                    Text(
                      reservation.telephone,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Gap(0.5.h),
                // Code + prix
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#${reservation.code}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      "${reservation.price} CFA",
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: appColorTextSecond,
                      ),
                    ),
                  ],
                ),
                Gap(1.h),
                // Boutons actions
                Row(
                  children: [
                    if (reservation.statut == "CONFIRME") ...[
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Marquer terminé",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Gap(2.w),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Modifier",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Gap(2.w),
                    ],
                    if (reservation.statut == "ATTENTE") ...[
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Confirmer",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Gap(2.w),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Refuser",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Gap(2.w),
                    ],
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Appeler",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

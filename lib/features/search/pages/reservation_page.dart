import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/features/search/search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class Service {
  final String name;
  final String description;
  final int price;
  final int duration;

  Service({
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
  });
}

class _ReservationPageState extends State<ReservationPage> {
  final List<Service> services = [
    Service(
      name: "Tresses Africaines",
      description: "Coiffure traditionnelle africaine",
      price: 15000,
      duration: 120,
    ),
    Service(
      name: "Locks / Dreadlocks",
      description: "Création et entretien de dreadlocks",
      price: 25000,
      duration: 180,
    ),
    Service(
      name: "Tissage",
      description: "Pose de tissage avec extensions",
      price: 20000,
      duration: 150,
    ),
    Service(
      name: "Coiffure Enfants",
      description: "Coiffure adaptée pour enfants",
      price: 10000,
      duration: 90,
    ),
  ];

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
                          child: Image.asset(
                            "assets/images/gal2.jpg",
                            height: 7.h,
                          ),
                        ),
                        Gap(2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Amina Diallo",
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
                                      text: " Marcory, Abidjan",
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
                child: ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DatePage(service: service),
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
                              service.name,
                              style: TextStyle(
                                color: appColorText,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              service.description,
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
                                  "${service.price} FCFA",
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
                                              " ${service.duration ~/ 60}h "
                                              "${service.duration % 60}min",
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

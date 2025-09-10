import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:afrolia/features/search/search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class DetailSearchPage extends StatefulWidget {
  const DetailSearchPage({super.key});

  @override
  State<DetailSearchPage> createState() => _DetailSearchPageState();
}

class _DetailSearchPageState extends State<DetailSearchPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> images = [
    "assets/images/gal1.jpg",
    "assets/images/gal2.jpg",
    "assets/images/gal3.jpg",
    "assets/images/gal4.jpg",
    "assets/images/gal5.jpg",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
              Container(
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
                          child: Image.asset(
                            "assets/images/gal2.jpg",
                            height: 10.h,
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
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "4.9",
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                    TextSpan(
                                      text: " (127 avis)",
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
                                      text: " Marcory, Abidjan",
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(1.h),
                              Text(
                                "5 ans d'expérience . Spécialiste tresses "
                                "& soins naturels",
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
                      "Passionnée par la beauté des cheveux afro, "
                      "je vous propose des coiffures modernes et "
                      "traditionnelles dans un cadre chaleureux. "
                      "Spécialisée dans les tresses, tissages et "
                      "soins naturels.",
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
                              "127",
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
                              "5 ans",
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
                              "98%",
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
                                  builder: (context) =>
                                      ReservationPage(),
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
                    GridView.builder(
                      itemCount: images.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 3.w,
                        mainAxisSpacing: 3.w,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(2.w),
                          child: Image.asset(images[index], fit: BoxFit.cover),
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
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
                              Text(
                                "Tresses africaines",
                                style: TextStyle(
                                  color: appColorText,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Tresses traditionnelles & modernes",
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
                                    "15 000 FCFA",
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
                                            text: " 2h",
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
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
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
                              Text(
                                "Lundi",
                                style: TextStyle(
                                  color: appColorText,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gap(2.h),
                              Wrap(
                                spacing: 2.w,
                                runSpacing: 1.h,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2.w),
                                    decoration: BoxDecoration(
                                      color: appColorFond,
                                      borderRadius: BorderRadius.circular(3.w),
                                      border: Border.all(
                                        width: 2,
                                        color: appColorBorder,
                                      ),
                                    ),
                                    child: Text(
                                      "09h:00",
                                      style: TextStyle(
                                        color: appColorText,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.w),
                                    decoration: BoxDecoration(
                                      color: appColorFond,
                                      borderRadius: BorderRadius.circular(3.w),
                                      border: Border.all(
                                        width: 2,
                                        color: appColorBorder,
                                      ),
                                    ),
                                    child: Text(
                                      "11h:00",
                                      style: TextStyle(
                                        color: appColorText,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.w),
                                    decoration: BoxDecoration(
                                      color: appColorFond,
                                      borderRadius: BorderRadius.circular(3.w),
                                      border: Border.all(
                                        width: 2,
                                        color: appColorBorder,
                                      ),
                                    ),
                                    child: Text(
                                      "14h:00",
                                      style: TextStyle(
                                        color: appColorText,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                builder: (context) =>
                    ReservationPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

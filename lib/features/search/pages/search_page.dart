import 'package:afrolia/features/search/search.dart';
import 'package:flutter/material.dart';

import 'package:afrolia/core/themes/themes.dart';
import 'package:gap/gap.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InputText(
                        hintText: "Rechercher par nom ou spécialité...",
                        keyboardType: TextInputType.text,
                        controller: search,
                        prefixIcon: Icon(Icons.search_outlined),
                        validatorMessage: "Veuillez saisir un mot",
                      ),
                    ),
                    Gap(2.w),
                    FloatingActionButton(
                      elevation: 0,
                      heroTag: "Filter",
                      shape: CircleBorder(),
                      backgroundColor: appColorBorder,
                      onPressed: () {},
                      child: Icon(Icons.tune_outlined, color: appColorText),
                    ),
                  ],
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailSearchPage(),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(3.w),
                                  child: Image.asset(
                                    "assets/images/gal2.jpg",
                                    height: 8.h,
                                  ),
                                ),
                                Positioned(
                                  top: -5,
                                  right: -5,
                                  child: CircleAvatar(
                                    radius: 3.w,
                                    backgroundColor: Colors.blueAccent,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
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
                                              text: " Marcory . 0.8 km",
                                              style: TextStyle(fontSize: 15.sp),
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
                                                Icons.access_time_outlined,
                                                size: 16,
                                                color: appColorBlack,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " 5 ans d'exp.",
                                              style: TextStyle(fontSize: 15.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(1.h),
                                  Wrap(
                                    spacing: 2.w,
                                    runSpacing: 1.h,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(2.w),
                                        decoration: BoxDecoration(
                                          color: appColorFond,
                                          borderRadius: BorderRadius.circular(
                                            10.w,
                                          ),
                                        ),
                                        child: Text(
                                          "Tresses",
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
                                          borderRadius: BorderRadius.circular(
                                            10.w,
                                          ),
                                        ),
                                        child: Text(
                                          "Tissage",
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
                                          borderRadius: BorderRadius.circular(
                                            10.w,
                                          ),
                                        ),
                                        child: Text(
                                          "Soins",
                                          style: TextStyle(
                                            color: appColorText,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "10 000 - 30 000 FCFA",
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
                                            color: index != 1
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
                                            index != 1
                                                ? "Disponible"
                                                : "Occupee",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: index != 1
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
                                          fontSize: 13.sp,
                                          AppConstants.btnReserver,
                                          height: 4.h,
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

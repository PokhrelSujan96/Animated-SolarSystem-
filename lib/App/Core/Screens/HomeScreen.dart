// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:solarlanet/App/Core/Screens/Satellites.dart';
import 'package:solarlanet/App/Core/Widgets/CustomAnimation.dart';
import 'package:solarlanet/App/Core/Widgets/CustomAppBar.dart';
import 'package:solarlanet/App/Core/Widgets/CustomRotation.dart';
import 'package:solarlanet/App/Core/Widgets/CustomShadowText.dart';
import 'package:solarlanet/App/Core/Widgets/MaterialApp.dart';
import 'package:solarlanet/App/Models/PlanetsModels.dart';
import 'package:solarlanet/App/Resources/Colors.dart';
import 'package:solarlanet/App/Resources/DummyDesc.dart';
import 'package:solarlanet/App/Resources/Images.dart';
import 'package:solarlanet/App/Resources/Shadow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static List<String> planetname = [
    'SUN',
    'MERCURY',
    'VENUS',
    'EARTH',
    'MARS',
    'JUPITER',
    'SATURN',
    'URANUS',
    'NEPTUNE'
  ];
  static List<String> planetdesc = [
    sunT,
    merT,
    venT,
    earT,
    marT,
    jupT,
    satT,
    urT,
    nepT
  ];

  static List<String> satName = [
    "",
    "",
    "",
    "MOON",
    "",
    "",
    "",
    "",
    "",
  ];

  static List url = [sun, mer, ven, ear, mar, jup, sat, ur, nep];

  static List satellite = [
    sunsat,
    mersat,
    vensat,
    moon,
    marsat,
    jupsat,
    satsat,
    ursat,
    nepsat
  ];

  final List<Planet> Planetdata = List.generate(
      planetname.length,
      (index) => Planet(planetname[index], '${url[index]}', planetdesc[index],
          '${satellite[index]}', satName[index]));

  final _pagePlanetController = PageController(viewportFraction: 0.35);

  double _currentPage = 0.0;

  void _planetScrollListener() {
    setState(() {
      _currentPage = _pagePlanetController.page!;
    });
  }

  @override
  void initState() {
    _pagePlanetController.addListener(_planetScrollListener);

    super.initState();
  }

  @override
  void dispose() {
    _pagePlanetController.removeListener(_planetScrollListener);
    _pagePlanetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return CustomMaterialApp(
      child: SafeArea(
        child: Stack(
          children: [
            //appbar
            Positioned(
                top: 20.h,
                left: 20.h,
                right: 20.h,
                child: SizedBox(
                    child: CustomAppBar(
                  text: "XORE",
                  child1: Icon(
                    Icons.rocket,
                    color: white,
                  ),
                  child2: Icon(
                    Icons.golf_course,
                    color: white,
                  ),
                ))),
            //back_shadow
            Positioned(
              left: 13.w,
              right: 13.w,
              bottom: -mq.height * 0.22.h,
              height: mq.height * 0.3.h,
              child: MyShadow(
                bRadius: 80.r,
                color: black.withOpacity(0.3),
                offsetmy: Offset.zero,
                sRadius: 35.r,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Transform.scale(
              scale: 1.6,
              alignment: Alignment.bottomCenter,
              child: PageView.builder(
                controller: _pagePlanetController,
                scrollDirection: Axis.vertical,
                itemCount: Planetdata.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    //empty while the index == 0;
                    return SizedBox.shrink();
                  }
                  final myPlanet = Planetdata[index - 1];
                  final result = _currentPage - index + 1;

                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);

                  return Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(
                            0.0,
                            MediaQuery.of(context).size.height /
                                2.6 *
                                (1 - value).abs())
                        ..scale(value),
                      child: Opacity(
                        opacity: opacity,
                        child: Stack(
                          children: [
                            Center(
                              child: MyCustomAnimation(
                                child: GestureDetector(
                                  onTap: () {
                                    // i havent uploaded other planet satellites except earth so i put the condition to navigate page only if planets contains satellites
                                    // you can change it

                                    (myPlanet.satName != "")
                                        ? Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                duration: Duration(seconds: 1),
                                                child: Satellites(
                                                  planet: myPlanet,
                                                )),
                                          )
                                        : SizedBox();
                                  },
                                  child: CustomRotation(
                                    child: SizedBox(
                                      height: 200.h,
                                      width: 200.w,
                                      child: Image.asset(
                                        myPlanet.ImageUrl,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 13.w,
                              right: 0.w,
                              bottom: -mq.height * 0.3.h,
                              height: mq.height * 0.4.h,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: black.withOpacity(0.75),
                                        blurRadius: 90.r,
                                        offset: Offset.zero,
                                        spreadRadius: 35.r)
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                left: 0,
                                right: 0,
                                bottom: -50.h,
                                height: 100.h,
                                child: MyCustomAnimation(
                                  child: Column(
                                    children: [
                                      ShadowTextElectro(
                                          text: myPlanet.name,
                                          bRadius: 10.r,
                                          offsetmy: Offset(2, 2),
                                          tSize: 12.sp,
                                          tColor: white),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 80.w),
                                        child: Center(
                                            child: ShadowTextElectroLato(
                                                text: myPlanet.desc,
                                                line: 3,
                                                bRadius: 2.r,
                                                offsetmy: Offset(2.0, 2.0),
                                                tSize: 6.sp,
                                                tColor: grey)),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

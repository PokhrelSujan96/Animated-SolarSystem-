// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:solarlanet/App/Core/Screens/SatelliteDetails.dart';
import 'package:solarlanet/App/Core/Widgets/CustomAnimation.dart';
import 'package:solarlanet/App/Core/Widgets/CustomAppBar.dart';
import 'package:solarlanet/App/Core/Widgets/CustomRotation.dart';
import 'package:solarlanet/App/Core/Widgets/CustomShadowText.dart';
import 'package:solarlanet/App/Core/Widgets/MaterialApp.dart';

import 'package:solarlanet/App/Models/PlanetsModels.dart';
import 'package:solarlanet/App/Resources/Colors.dart';
import 'package:solarlanet/App/Resources/Shadow.dart';

import '../../Resources/Animation.dart';

class Satellites extends StatefulWidget {
  Planet planet;
  Satellites({
    Key? key,
    required this.planet,
  }) : super(key: key);

  @override
  State<Satellites> createState() => SatellitesState();
}

class SatellitesState extends State<Satellites> {
  final value = 0.4;

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

            Transform(
                transform: Matrix4.identity()
                  ..setEntry(2, 2, 0.001)
                  ..translate(
                      0.0,
                      MediaQuery.of(context).size.height /
                          2.5 *
                          (1 - value).abs())
                  ..scale(value),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: 0.7,
                  child: SizedBox(
                    height: 200.h,
                    width: 150.w,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                duration: Duration(seconds: 5),
                                child: SatelliteDetails(
                                  myplanet: widget.planet,
                                )));
                      },
                      child: Hero(
                        tag: widget.planet.satellite,
                        child: MyCustomAnimation(
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Image.asset(
                              widget.planet.satellite,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: CustomRotation(
                  child: MyCustomAnimation(
                    child: SizedBox(
                      height: mq.height / 1.5.h,
                      width: mq.width.w,
                      child: Image.asset(
                        widget.planet.ImageUrl,
                        fit: BoxFit.fitHeight,
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
                height: mq.height * 0.45.h,
                child: MyShadow(
                    color: black.withOpacity(0.7),
                    offsetmy: Offset.zero,
                    sRadius: 1.r,
                    bRadius: 90.r)),
            Positioned(
                left: 20.w,
                right: 20.w,
                bottom: 20.h,
                child: MyCustomAnimation(
                  child: Column(
                    children: [
                      ShadowTextElectro(
                          text: widget.planet.name,
                          bRadius: 10.r,
                          offsetmy: Offset(2, 2),
                          tSize: 22.sp,
                          tColor: white),
                      SizedBox(
                        height: 5.h,
                      ),
                      Center(
                          child: ShadowTextElectroLato(
                              text: widget.planet.desc,
                              line: 3,
                              bRadius: 2.r,
                              offsetmy: Offset(2.0, 2.0),
                              tSize: 9.sp,
                              tColor: grey))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class ZoomPageRoute<T> extends MaterialPageRoute<T> {
  ZoomPageRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.0).animate(CurvedAnimation(
          reverseCurve: Curves.easeIn,
          parent: animation,
          curve: Interval(0.0, 1.0, curve: Curves.easeIn))),
      child: child,
    );
  }
}

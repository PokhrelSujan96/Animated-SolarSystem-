// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solarlanet/App/Core/Widgets/CustomAppBar.dart';
import 'package:solarlanet/App/Core/Widgets/CustomRotation.dart';
import 'package:solarlanet/App/Core/Widgets/CustomShadowText.dart';

import 'package:solarlanet/App/Models/PlanetsModels.dart';
import 'package:solarlanet/App/Resources/Colors.dart';
import 'package:solarlanet/App/Resources/DummyDesc.dart';
import 'package:solarlanet/App/Resources/Images.dart';
import 'package:solarlanet/App/Resources/Shadow.dart';

class SatelliteDetails extends StatefulWidget {
  Planet myplanet;
  SatelliteDetails({
    Key? key,
    required this.myplanet,
  }) : super(key: key);

  @override
  State<SatelliteDetails> createState() => SatelliteDetailsState();
}

class SatelliteDetailsState extends State<SatelliteDetails> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(space), fit: BoxFit.cover)),
          ),
          Positioned(
              top: 20.h,
              right: 20.w,
              left: 20.w,
              child: SafeArea(
                  child: CustomAppBar(
                onTap: () {
                  Navigator.pop(context);
                },
                text: "SATELLITE",
                child1: Icon(
                  Icons.arrow_back_ios_new,
                  color: white,
                ),
                child2: Icon(
                  Icons.rocket_launch,
                  color: white,
                ),
              ))),
          Align(
            alignment: Alignment.bottomCenter,
            child: Hero(
                tag: widget.myplanet.satellite,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: CustomRotation(
                    child: SizedBox(
                        height: mq.height / 1.5.h,
                        width: mq.width.w,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Image.asset(
                            widget.myplanet.satellite,
                            fit: BoxFit.contain,
                          ),
                        )),
                  ),
                )),
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
            bottom: 30.h,
            right: 20.w,
            left: 20.w,
            child: ShadowTextElectroLato(
              text: moonT,
              line: 4,
              bRadius: 30.r,
              offsetmy: Offset(2, 2),
              tSize: 10.sp,
              tColor: white.withOpacity(0.7),
            ),
          )
        ],
      ),
    );
  }
}

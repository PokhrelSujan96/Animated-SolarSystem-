// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:solarlanet/App/Resources/Colors.dart';

const AppBarShadow =
    BoxShadow(color: white, offset: Offset(4, 4), spreadRadius: 1);

class MyShadow extends StatelessWidget {
  final Color color;
  final Offset offsetmy;
  double sRadius;
  double bRadius;
  final child;
  MyShadow({
    Key? key,
    required this.color,
    required this.offsetmy,
    required this.sRadius,
    required this.bRadius, this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: color,
            offset: offsetmy,
            spreadRadius: sRadius,
            blurRadius: bRadius)
      ]),
      child: child,
    );
  }
}

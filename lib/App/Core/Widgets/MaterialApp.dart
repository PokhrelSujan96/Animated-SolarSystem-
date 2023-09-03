// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:solarlanet/App/Resources/Images.dart';

class CustomMaterialApp extends StatelessWidget {
  final child;
  const CustomMaterialApp({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage(space), fit: BoxFit.cover)),
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solarlanet/App/Core/Screens/HomeScreen.dart';
import 'package:solarlanet/App/Resources/Colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const SolarApp());
}

class SolarApp extends StatelessWidget {
  const SolarApp({super.key});

  @override
  Widget build(BuildContext context) {
    // used screenutil for a screen size adaption ! you can modify accordingly
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SolarPlanet',
          theme: ThemeData(
              scaffoldBackgroundColor: white,
              primarySwatch: Colors.blue,
              useMaterial3: true),
          home: const HomeScreen(),
        );
      },
    );
  }
}

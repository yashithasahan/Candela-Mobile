import 'package:candela_maker/src/features/spalsh_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

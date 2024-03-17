import 'dart:async';

import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../authentication/register/register.dart';
import '../authentication/services/session_service.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userId;

  Future getValidationData() async {
    SessionManagerService.getUserId().then((value) {
      setState(() {
        userId = value;
      });
    });
  }

  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(const Duration(seconds: 3), () {
        Get.to(() => userId == null ? const Register() : const HomeScreen());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Center(
        child: Image.asset(
          'assets/images/candela-vip-splash.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

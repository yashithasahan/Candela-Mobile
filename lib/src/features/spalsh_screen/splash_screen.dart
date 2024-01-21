import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Center(
          child: 
          // SvgPicture.network('https://upload.wikimedia.org/wikipedia/commons/f/f1/Heart_coraz%C3%B3n.svg'),
          SvgPicture.asset('assets/splash_screen.svg'),
          // Image.asset("assets/splash_screen/splash_screen.png"),
          ),
    );
  }
}

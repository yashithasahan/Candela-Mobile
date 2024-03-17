import 'package:candela_maker/src/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/models/user_model.dart';
import '../spalsh_screen/splash_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return const SplashScreen();
    } else {
      return const HomeScreen();
    }
  }
}

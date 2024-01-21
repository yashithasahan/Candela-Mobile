import 'package:candela_maker/src/features/membership_level/membership_level.dart';
import 'package:candela_maker/src/features/register/register4.dart';
import 'package:candela_maker/src/features/register/register5.dart';
import 'package:candela_maker/src/features/spalsh_screen/splash_screen.dart';
import 'package:candela_maker/src/features/vip_agreement/vip_agreement_agree.dart';
import 'package:candela_maker/src/features/vip_agreement/vip_agreement_send_request.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: VIPAgreementAgree(), 
          // Text('Hello World!'),
        ),
      ),
    );
  }
}

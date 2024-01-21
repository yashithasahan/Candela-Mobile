import 'package:flutter/material.dart';
import 'src/features/vip_payment/vip_payment_screen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: VIPPaymentScreen(),);
  }
}

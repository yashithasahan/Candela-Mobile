// ignore_for_file: deprecated_member_use

import 'package:candela_maker/src/features/authentication/register/register.dart';
import 'package:candela_maker/src/features/membership_level/membership_level.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../constants/constants.dart';
import '../features/vip_payment/vip_payment_screen.dart';
import '../features/vip_report/vip_report_access.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.index});

  final int index;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  void _onItemTapped(index) {
    setState(() {});
    _selectedIndex = index;

    if (_selectedIndex == 0) {
      Get.to(() => const Register());
    } else if (_selectedIndex == 1) {
      Get.to(() => const MembershipLevel());
    } else if (_selectedIndex == 2) {
      Get.to(() => const VIPPaymentScreen());
    } else if (_selectedIndex == 3) {
      Get.to(() => const VIPReportAccess());
    } else if (_selectedIndex == 4) {
      Get.back();
    } else if (_selectedIndex == 5) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BottomNavigationBar(
      backgroundColor: kBlackColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset(
            'assets/images/home-icon.png',
            width: size.width * 0.1,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset(
            'assets/images/stopwatch-icon.png',
            width: size.width * 0.1,
          ),
          label: 'Dance',
        ),
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset(
            'assets/images/payment-icon.png',
            width: size.width * 0.1,
          ),
          label: 'Pay',
        ),
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset(
            'assets/images/report-icon.png',
            width: size.width * 0.1,
          ),
          label: 'Report',
        ),
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset(
            'assets/images/arrow-left.png',
            width: size.width * 0.1,
          ),
          label: 'Back',
        ),
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset(
            'assets/images/arrow-right.png',
            width: size.width * 0.1,
          ),
          label: 'Forward',
        ),
      ],
      currentIndex: _selectedIndex,
      unselectedItemColor: kTextColor,
      showUnselectedLabels: true,
      onTap: _onItemTapped,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: deprecated_member_use

import 'package:candela_maker/src/features/authentication/register/register.dart';
import 'package:candela_maker/src/features/membership_level/membership_level.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../constants/constants.dart';
import '../features/vip_payment/vip_payment_screen.dart';
import '../features/vip_report/vip_report_access.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  final int index;
  final int currentIndex;
  final Function(int) onTap;
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
    double imageWidth = MediaQuery.of(context).size.width / 12;
    return BottomNavigationBar(
      backgroundColor: kBlackColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset(
            'assets/icons/home.png',
            width: imageWidth,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset(
            'assets/icons/stopwatch.png',
            width: imageWidth,
          ),
          label: 'Dance',
        ),
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset(
            'assets/icons/Reports.png',
            width: imageWidth,
          ),
          label: 'Pay',
        ),
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset(
            'assets/icons/payment.png',
            width: imageWidth,
          ),
          label: 'Report',
        ),
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset(
            'assets/icons/arrowFront.png',
            width: imageWidth,
          ),
          label: 'Back',
        ),
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset(
            'assets/icons/arrowBack.png',
            width: imageWidth,
          ),
          label: 'Forward',
        ),
      ],
      currentIndex: widget.currentIndex,
      unselectedItemColor: kTextColor,
      showUnselectedLabels: true,
      onTap: widget.onTap,
    );
  }
}

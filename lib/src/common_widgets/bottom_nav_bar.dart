// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

import '../constants/constants.dart';
import '../features/home/home_screen.dart';
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
      Get.offAll(() => const HomeScreen());
    } else if (_selectedIndex == 1) {
      Get.to(() => const VIPPaymentScreen());
    } else if (_selectedIndex == 2) {
      Get.back();
    } else if (_selectedIndex == 3) {
      Get.to(() => const VIPReportAccess());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: kBlackColor,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Icon(Icons.home, color: kPrimaryColor),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: SvgPicture.asset(
            'assets/icons/nav-icon-2.svg',
            width: 23,
            color: kPrimaryColor,
          ),
          label: 'Payment Record',
        ),
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset('assets/images/arrow-white-left.png'),
          activeIcon: Image.asset('assets/images/arrow-black-left.png'),
          label: 'Back',
        ),
        BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Image.asset('assets/images/arrow-white-right.png'),
          activeIcon: Image.asset('assets/images/arrow-black-right.png'),
          label: 'Forward',
        ),
      ],
      currentIndex: _selectedIndex,
      unselectedItemColor: kTextColor,
      selectedItemColor: kPrimaryColor,
      showUnselectedLabels: true,
      onTap: _onItemTapped,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

import '../constants/constants.dart';
import '../features/home/home_screen.dart';
import '../features/vip_payment/vip_payment_screen.dart';

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
      Get.to(() => const HomeScreen());
    } else if (_selectedIndex == 1) {
      Get.to(() => const VIPPaymentScreen());
    } else if (_selectedIndex == 2) {
    } else if (_selectedIndex == 3) {}
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          backgroundColor: kSecondaryColor,
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/nav-icon-2.svg',
            width: 30,
          ),
          label: 'Payment Record',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/nav-icon-3.svg',
            width: 35,
          ),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/nav-icon-4.svg',
            width: 30,
          ),
          label: 'Notification',
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

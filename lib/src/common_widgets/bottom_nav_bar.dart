import 'package:flutter/material.dart';
import '../constants/constants.dart';

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

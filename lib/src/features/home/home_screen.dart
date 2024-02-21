import 'dart:async';

import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/authentication/register/register.dart';
import 'package:candela_maker/src/features/authentication/sign_in/sign_in_screen.dart';
import 'package:candela_maker/src/features/home/timer_screen.dart';
import 'package:candela_maker/src/features/home/widgets/song_timer.dart';
import 'package:candela_maker/src/features/home/widgets/songs_list.dart';
import 'package:candela_maker/src/features/insurance_screen/insurance_screen.dart';
import 'package:candela_maker/src/features/vip_payment/vip_payment_screen.dart';
import 'package:candela_maker/src/features/vip_report/vip_report_access.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../common_widgets/bottom_nav_bar.dart';
import '../membership_level/controller/membership_controller.dart';
import '../membership_level/membership_level.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer = Timer.periodic(const Duration(seconds: 5), (timer) {});
  final membershipController = Get.put(MembershipController());

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      if (index == 4) {
        if (_selectedIndex > 0) {
          _selectedIndex -= 1;
        }
      } else if (index == 5) {
        if (_selectedIndex < 5) {
          _selectedIndex += 1;
        }
      } else {
        _selectedIndex = index;
      }
    });
  }

  final List<Widget> _widgetOptions = [
    const Register(),
    const TimerScreen(),
    const VIPPaymentScreen(),
    const VIPReportAccess(),
    const MembershipLevel(),
    const InsuranceScreen()
  ];

  final _auth = FirebaseAuth.instance;
  bool isLoading = true;
  DateTime? date;
  DateTime? subscriptionExpiryDate;

  @override
  void initState() {
    super.initState();
    fetchMembershipData().then((value) => membershipAlert());
  }

  Future<void> fetchMembershipData() async {
    String? uid = _auth.currentUser?.uid;
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('membership')
        .doc(uid)
        .get();
    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      setState(() {
        membershipController.membershipLevel.value =
            userData['membershipLevel'] ?? 0;
        date = userData['paymentDate']?.toDate();
        subscriptionExpiryDate = userData['expiryDate']?.toDate();
        isLoading = false;
      });
    }
  }

  void membershipAlert() {
    _timer = Timer.periodic(const Duration(seconds: 90), (timer) {
      if (membershipController.membershipLevel.value > 0) {
        if (subscriptionExpiryDate != null &&
            DateTime.now().isAfter(subscriptionExpiryDate!)) {
          membershipController.membershipLevel.value = 0;
          updateMembershipData();
          Fluttertoast.showToast(
              msg: "Your subscription has expired.\nPlease renew it.",
              backgroundColor: Colors.red);
          Get.to(() => const MembershipLevel());
          _timer?.cancel();
        }
      } else {
        Get.to(() => const MembershipLevel());
      }
    });
  }

  void updateMembershipData() async {
    String? uid = _auth.currentUser!.uid;
    await FirebaseFirestore.instance.collection('membership').doc(uid).update({
      'membershipCost': 0,
      'membershipLevel': membershipController.membershipLevel.value,
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: kBgColor,
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ))
              : Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
          bottomNavigationBar: BottomNavBar(
            index: 0,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
          resizeToAvoidBottomInset: false,
        ));
  }
}

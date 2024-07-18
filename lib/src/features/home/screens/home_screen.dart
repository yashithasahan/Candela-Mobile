import 'dart:async';

import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/home/controllers/timer_controller.dart';
import 'package:candela_maker/src/features/home/screens/timer_screen.dart';
import 'package:candela_maker/src/features/profile/profile_screen.dart';
import 'package:candela_maker/src/features/vip_payment/vip_payment_screen.dart';
import 'package:candela_maker/src/features/vip_report/vip_report_access.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/bottom_nav_bar.dart';
import '../../../common_widgets/primary_button.dart';
import '../../membership_level/controller/membership_controller.dart';
import '../../membership_level/screens/membership_level.dart';
import '../../vip_money_links/vip_money_links_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer = Timer.periodic(const Duration(seconds: 5), (timer) {});
  final membershipController = Get.put(MembershipController());
  final timerController = Get.put(TimerController());
  String language = "English";
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    print("index $index");
    setState(() {
      if (index == 4) {
        if (_selectedIndex > 0) {
          _selectedIndex -= 1;
        }
      } else if (index == 5) {
        if (_selectedIndex < 4) {
          _selectedIndex += 1;
        }
      } else {
        _selectedIndex = index;
      }
    });
    print("selected index $_selectedIndex");
  }

  final List<Widget> _widgetOptions = [
    const Profile(),
    const TimerScreen(),
    const VIPPaymentScreen(),
    const VIPReportAccess(),
    // const MembershipLevel(
    //   isPopUp: false,
    // ),
    const VIPMoneyLinks(),
  ];

  final _auth = FirebaseAuth.instance;
  bool isLoading = true;
  DateTime? subscriptionExpiryDate;
  String? uid;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchLanguage() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

      setState(() {
        language = userData['language'];
        timerController.amout.value = userData['songPrice'];
      });

      var locale = language == "Spanish"
          ? const Locale('es', 'ES')
          : const Locale('en', 'US');
      Get.updateLocale(locale);
    }
  }

  Future<void> fetchData() async {
    uid = _auth.currentUser?.uid;

    fetchLanguage();

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('membership')
        .doc(uid)
        .get();
    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      DateTime trailEndDate = userData['trialEndDate']?.toDate();
      DateTime expiryDate = userData['expiryDate']?.toDate() ?? DateTime.now();

      setState(() {
        membershipController.membershipLevel.value =
            userData['membershipLevel'];
        membershipController.membershipStatus.value = userData['status'];

        isLoading = false;
      });

      if (DateTime.now().isAfter(trailEndDate) &&
          membershipController.membershipStatus.value == 'Trial') {
        await FirebaseFirestore.instance
            .collection('membership')
            .doc(uid)
            .update({
          'membershipLevel': 0,
          'membershipCost': 0,
          'status': 'TrialExpired',
        });
        Get.off(() => const HomeScreen());
      } else if (DateTime.now().isAfter(expiryDate) &&
          membershipController.membershipStatus.value == 'Paid') {
        await FirebaseFirestore.instance
            .collection('membership')
            .doc(uid)
            .update({
          'membershipLevel': 0,
          'membershipCost': 0,
          'status': 'SubcriptionExpired',
        });
        Get.off(() => const HomeScreen());
      }

      switch (membershipController.membershipStatus.value) {
        case 'Active':
        // trialAlert();
        case 'Trial':
          break;
        case 'TrialExpired':
        // membershipAlert();
        case 'Paid':
          break;
        case 'SubcriptionExpired':
        // membershipAlert();
        default:
          break;
      }
    }
  }

  void trialAlert() {
    showDialog<String>(
      barrierColor: kSecondaryColor.withOpacity(0.7),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kBlackColor,
          contentPadding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
          actionsPadding: const EdgeInsets.only(bottom: 40),
          title: Text(
            "Here’s 1 month free trial just for you.".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          content: Text(
            "You have to subscribe to get access. After the one-month trial is canceled."
                .tr,
            textAlign: TextAlign.center,
            style: const TextStyle(color: kTextColor, fontSize: 14),
          ),
          actions: <Widget>[
            Center(
              child: PrimaryButton(
                  text: 'Get 1 Month Free'.tr,
                  press: () async {
                    await FirebaseFirestore.instance
                        .collection('membership')
                        .doc(uid)
                        .update({
                      'status': 'Trial',
                    });
                    Get.back();
                  },
                  width: 0.6),
            )
          ],
        );
      },
    );
  }

  void membershipAlert() {
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (!membershipController.isDialogOpen.value) {
        showDialog<String>(
          barrierDismissible: false,
          barrierColor: kSecondaryColor.withOpacity(0.7),
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: kBlackColor,
              contentPadding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              actionsPadding: const EdgeInsets.only(bottom: 40),
              content: Text(
                membershipController.membershipStatus.value == 'TrialExpired'
                    ? 'Free Trial Expired. Please Subscribe'.tr
                    : 'Subscription Expired. Please Subscribe'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: kTextColor, fontSize: 18),
              ),
              actions: <Widget>[
                Center(
                  child: PrimaryButton(
                    text: 'Subscribe'.tr,
                    press: () {
                      setState(() {
                        _timer?.cancel();
                        Get.back();
                        Get.to(() => const MembershipLevel());
                        membershipController.isDialogOpen.value = false;
                      });
                    },
                    width: 0.5,
                  ),
                ),
              ],
            );
          },
        );
        membershipController.isDialogOpen.value = true;
      } else {
        Get.back();
        membershipController.isDialogOpen.value = false;
      }
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
      ),
    );
  }
}

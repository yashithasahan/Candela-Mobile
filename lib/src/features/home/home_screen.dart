import 'dart:async';

import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/home/widgets/song_timer.dart';
import 'package:candela_maker/src/features/home/widgets/songs_list.dart';
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
          appBar: AppBar(
            forceMaterialTransparency: true,
            automaticallyImplyLeading: false,
            centerTitle: true,
            foregroundColor: kTextColor,
            title: const Text(
              'VIP DANCES',
              style: TextStyle(
                  fontFamily: "Roboto",
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
          ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ))
              : SafeArea(
                  child: Column(
                  children: [
                    Flexible(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(mainPadding),
                          child: const Column(
                            children: [
                              SongTimer(),
                            ],
                          ),
                        )),
                    Flexible(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(secondaryPadding),
                          child: const SongList(),
                        )),
                  ],
                )),
          bottomNavigationBar: const BottomNavBar(index: 0),
          resizeToAvoidBottomInset: false,
        ));
  }
}

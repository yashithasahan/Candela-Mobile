import 'dart:convert';
import 'package:candela_maker/src/common_widgets/primary_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/widgets/membership_level_btn.dart';
import 'package:candela_maker/src/widgets/membership_level_description.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../authentication/models/user_model.dart';
import '../authentication/services/firestore_service.dart';
import 'controller/membership_controller.dart';
import 'model/membership_model.dart';

class MembershipLevel extends StatefulWidget {
  const MembershipLevel({super.key});

  @override
  State<MembershipLevel> createState() => _MembershipLevelState();
}

class _MembershipLevelState extends State<MembershipLevel> {
  MembershipController membershipController = Get.put(MembershipController());
  int level = 0;
  int membershipLevel = 0;
  int membershipCost = 0;
  late UserModel user;
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  DateTime now = DateTime.now();

  int calculateMembershipCost(int level) {
    switch (level) {
      case 0:
        return 0;
      case 1:
        return 15;
      case 2:
        return 25;
      case 3:
        return 35;
      case 4:
        return 500;
      default:
        return 0;
    }
  }

  Future<void> initPaymentSheet(context,
      {required String email, required int amount}) async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://us-central1-candela-maker.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {'email': email, 'amount': amount.toString()});

      final jsonResponse = jsonDecode(response.body);

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: jsonResponse['paymentIntent'],
        customerId: jsonResponse['customer'],
        customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
        merchantDisplayName: 'Flutter Stripe',
        appearance: const PaymentSheetAppearance(
            primaryButton: PaymentSheetPrimaryButtonAppearance(
                shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
                colors: PaymentSheetPrimaryButtonTheme(
                    light: PaymentSheetPrimaryButtonThemeColors(
                  background: kPrimaryColor,
                  text: Colors.black,
                )))),
      ));
      await Stripe.instance.presentPaymentSheet();
      Fluttertoast.showToast(msg: 'Payment Successful');
      saveMembershipPayment();

      membershipController.membershipLevel.value = level;
    } catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(msg: 'Payment failed');
      } else {
        Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
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
        membershipLevel = userData['membershipLevel'] ?? 0;
        level = membershipLevel;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMembershipData();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel?>(context) ?? UserModel(id: '');
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        appBar: AppBar(
          backgroundColor: kBgColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          foregroundColor: kTextColor,
          title: const Text(
            "MEMBERSHIP LEVEL ",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: kDefaultPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     const MembershipLevelDescription(
                //         description:
                //             "\$0 per month-Timer, Song Count, Realtime Onscreen / Email Report. We process payment for additional \$5 per dance.  \$5 additional fee for every song automatically added to total.  We receive payment in crypto, credit/debit card or zelle for you and send you payment minus \$5 per song."),
                //     MembershipLevelButton(
                //       level: 0,
                //       press: () {
                //         setState(() {
                //           level = 0;
                //           membershipController.membershipLevel.value = level;
                //         });
                //       },
                //       textColor: membershipController.membershipLevel.value == 0
                //           ? kBgColor
                //           : Colors.white,
                //       btnColor: membershipController.membershipLevel.value == 0
                //           ? [const Color(0xFFDEA72C), const Color(0xFFF59C0D)]
                //           : [Colors.grey, Colors.grey],
                //     )
                //   ],
                // ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const MembershipLevelDescription(
                        description:
                            "\$15 per month- Timer & Song Count. You process your own payments."),
                    MembershipLevelButton(
                      level: 1,
                      press: () {
                        setState(() {
                          level = 1;
                        });
                      },
                      textColor: level == 1 ? kBgColor : Colors.white,
                      btnColor: level == 1
                          ? [const Color(0xFFDEA72C), const Color(0xFFF59C0D)]
                          : [Colors.grey, Colors.grey],
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const MembershipLevelDescription(
                        description:
                            "\$25 per month-Timer, Song Count, Realtime Onscreen / Email Report. You process your payments, we record on app transaction for you."),
                    MembershipLevelButton(
                      level: 2,
                      press: () {
                        setState(() {
                          level = 2;
                        });
                      },
                      textColor: level == 2 ? kBgColor : Colors.white,
                      btnColor: level == 2
                          ? [const Color(0xFFDEA72C), const Color(0xFFF59C0D)]
                          : [Colors.grey, Colors.grey],
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const MembershipLevelDescription(
                        description:
                            "\$35 per month-Timer, Song Count, Realtime Onscreen / Email Report. You process your payments, we record on app transaction for you."),
                    MembershipLevelButton(
                      level: 3,
                      press: () {
                        setState(() {
                          level = 3;
                        });
                      },
                      textColor: level == 3 ? kBgColor : Colors.white,
                      btnColor: level == 3
                          ? [const Color(0xFFDEA72C), const Color(0xFFF59C0D)]
                          : [Colors.grey, Colors.grey],
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const MembershipLevelDescription(
                        description:
                            "VIP MANAGER - Full Functions & Multi User Vip Manager \$500 per month for every 25 users"),
                    MembershipLevelButton(
                      level: 4,
                      press: () {
                        setState(() {
                          level = 4;
                        });
                      },
                      textColor: level == 4 ? kBgColor : Colors.white,
                      btnColor: level == 4
                          ? [const Color(0xFFDEA72C), const Color(0xFFF59C0D)]
                          : [Colors.grey, Colors.grey],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: membershipLevel != level,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ))
                      : PrimaryButton(
                          text: 'SUBSCRIBE',
                          press: () async {
                            setState(() {
                              isLoading = true;
                            });
                            if (level == 0) {
                              saveMembershipPayment();
                            } else {
                              membershipCost = calculateMembershipCost(level);
                              await initPaymentSheet(context,
                                  email: '${user.email}',
                                  amount: membershipCost * 100);
                            }
                            setState(() {
                              isLoading = false;
                            });

                            Get.back();
                          },
                          width: 0.5),
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveMembershipPayment() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    try {
      if (user != null) {
        final membershipPayment = MembershipModel(
          membershipLevel: level,
          membershipCost: membershipCost,
          paymentDate: now,
          expiryDate: now.add(const Duration(days: 30)),
        );

        await FireStoreService().addMembershipPayments(membershipPayment, user);
        Fluttertoast.showToast(msg: "Membership saved");
        Get.back();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

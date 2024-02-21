import 'dart:convert';
import 'package:candela_maker/src/common_widgets/primary_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/widgets/membership_level_btn.dart';
import 'package:candela_maker/src/widgets/membership_level_description.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../common_widgets/bottom_nav_bar.dart';
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
  int level = 0;
  int membershipCost = 0;
  late UserModel user;
  bool isLoading = false;
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
    } catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(msg: 'Payment failed');
      } else {
        Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel?>(context) ?? UserModel(id: '');
    final membershipController = Get.put(MembershipController());
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const MembershipLevelDescription(
                        description:
                            "\$0 per month-Timer, Song Count, Realtime Onscreen / Email Report. We process payment for additional \$5 per dance.  \$5 additional fee for every song automatically added to total.  We receive payment in crypto, credit/debit card or zelle for you and send you payment minus \$5 per song."),
                    MembershipLevelButton(
                      level: 0,
                      press: () {
                        setState(() {
                          level = 0;
                          membershipController.membershipLevel.value = level;
                        });
                      },
                    )
                  ],
                ),
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
                          membershipController.membershipLevel.value = level;
                        });
                      },
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
                          membershipController.membershipLevel.value = level;
                        });
                      },
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
                            membershipController.membershipLevel.value = level;
                          });
                        })
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
                            membershipController.membershipLevel.value = level;
                          });
                        })
                  ],
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const CircularProgressIndicator(
                        color: kPrimaryColor,
                      )
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
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(index: 0),
      ),
    );
  }

  Future<void> saveMembershipPayment() async {
    try {
      if (user.id != null) {
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

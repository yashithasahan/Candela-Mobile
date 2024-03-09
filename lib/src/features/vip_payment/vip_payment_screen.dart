import 'dart:convert';

import 'package:candela_maker/src/common_widgets/primary_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../authentication/services/firestore_service.dart';
import '../home/controllers/timer_controller.dart';
import 'model/payment_model.dart';
import 'widgets/payment_box.dart';
import 'widgets/total_box.dart';
import 'package:http/http.dart' as http;

class VIPPaymentScreen extends StatefulWidget {
  const VIPPaymentScreen({super.key});

  @override
  State<VIPPaymentScreen> createState() => _VIPPaymentScreenState();
}

class _VIPPaymentScreenState extends State<VIPPaymentScreen> {
  final tipController = TextEditingController();
  final timerController = Get.put(TimerController());
  int totalPayment = 0;
  int vipDances = 0;
  int totalSongs = 0;
  DateTime today = DateTime.now();
  bool isLoading = false;
  bool ispaymentDone = false;
  String totalDuration = '00:00:00';

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
      savePaymentData();
      Fluttertoast.showToast(msg: 'payment-success'.tr);
    } catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(
            msg: 'Error from Stripe: ${e.error.localizedMessage}');
      } else {
        Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    tipController.text = '0';
    vipDances = timerController.totalAmout.value;
    totalSongs = timerController.numberOfSongs.value;
    totalPayment = vipDances;
    totalDuration = timerController.time.value;
  }

  @override
  void dispose() {
    tipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        centerTitle: true,
        foregroundColor: kTextColor,
        title: Text(
          'vip-payment'.tr,
          style: const TextStyle(
              fontFamily: "Roboto",
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 26),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.close, color: kPrimaryColor),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'total-payment'.tr,
              style: const TextStyle(color: kTextColor, fontSize: 26),
            ),
            const SizedBox(
              height: 20,
            ),
            TotalBox(
              width: 0.6,
              fontSize: 26,
              text: totalPayment.toString(),
            ),
            const SizedBox(
              height: 40,
            ),
            PaymentBox(
              text: 'dances'.tr,
              subText: '\$ ${vipDances.toString()}',
            ),
            PaymentBox(
              text: 'total-songs'.tr,
              subText: totalSongs.toString(),
            ),
            PaymentBox(
              text: 'timer'.tr,
              subText: totalDuration,
            ),
            PaymentBox(
              text: 'average-song-price'.tr,
              subText: '\$ ${(vipDances / totalSongs).toString()}',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 20, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'tip'.tr,
                        style: const TextStyle(
                            color: kTextColor, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: size.width * 0.25,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                            border: Border.all(color: kTextColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextField(
                          controller: tipController,
                          cursorColor: kTextColor,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixText: '\$ ',
                              prefixStyle: TextStyle(color: kTextColor),
                              contentPadding: EdgeInsets.all(10)),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: kTextColor),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                        child: ElevatedButton(
                            onPressed: () => showDialog<String>(
                                  barrierColor:
                                      kSecondaryColor.withOpacity(0.7),
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    backgroundColor: kBlackColor,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 50, 20, 20),
                                    actionsPadding:
                                        const EdgeInsets.only(bottom: 40),
                                    content: Text(
                                      '\$ ${tipController.text} ${'tip-alert'.tr}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: kTextColor, fontSize: 18),
                                    ),
                                    actions: <Widget>[
                                      Center(
                                        child: PrimaryButton(
                                            text: 'yes'.tr,
                                            press: () {
                                              Get.back();
                                              setState(() {
                                                totalPayment = vipDances +
                                                    int.parse(
                                                        tipController.text);
                                              });
                                            },
                                            width: 0.5),
                                      )
                                    ],
                                  ),
                                ),
                            child: Text(
                              'add'.tr,
                              style: const TextStyle(color: kBlackColor),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ))
                : PrimaryButton(
                    text: 'pay-vip-now'.tr,
                    press: () async {
                      if (totalPayment == 0) {
                        Fluttertoast.showToast(msg: 'payment-process'.tr);
                      } else {
                        if (!ispaymentDone) {
                          savePaymentData();
                          // await initPaymentSheet(context,
                          //     email: '${user.email}', amount: totalPayment * 100);
                        } else {
                          Fluttertoast.showToast(
                            msg: 'payment-done'.tr,
                          );
                        }
                      }
                    },
                    width: 0.6),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> savePaymentData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        final payments = PaymentModel(
          userId: user.uid,
          vipPayment: vipDances,
          tipPayment: int.parse(tipController.text),
          totalPayment: totalPayment,
          paymentDate: today,
          totalSongs: totalSongs,
          duration: totalDuration,
        );

        await FireStoreService().addPayments(payments, user);
        Fluttertoast.showToast(msg: "payment-data-save-alert".tr);
        timerController.numberOfSongs.value = 0;
        timerController.totalAmout.value = 0;
        timerController.time.value = '00:00';
      }
      setState(() {
        isLoading = false;
        ispaymentDone = true;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

import 'package:candela_maker/src/common_widgets/primary_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/bottom_nav_bar.dart';
import '../authentication/models/user_model.dart';
import '../authentication/services/firestore_service.dart';
import '../home/controllers/timer_controller.dart';
import '../home/home_screen.dart';
import 'model/payment_model.dart';
import 'widgets/payment_box.dart';
import 'widgets/total_box.dart';

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
  late UserModel user;
  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
    tipController.text = '0';
    vipDances = timerController.totalAmout.value;
    totalPayment = vipDances;
  }

  @override
  void dispose() {
    tipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel?>(context) ?? UserModel(id: '');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        centerTitle: true,
        foregroundColor: kTextColor,
        title: const Text(
          'VIP PAYMENT',
          style: TextStyle(
              fontFamily: "Roboto",
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 26),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Total Payment',
            style: TextStyle(color: kTextColor, fontSize: 26),
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
            text: 'VIP Dances',
            subText: '\$ ${vipDances.toString()}',
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
                    const Text(
                      'Tip',
                      style: TextStyle(
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
                                barrierColor: kSecondaryColor.withOpacity(0.7),
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  backgroundColor: kBlackColor,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 50, 20, 20),
                                  actionsPadding:
                                      const EdgeInsets.only(bottom: 40),
                                  content: Text(
                                    '\$ ${tipController.text} amount added as tip. Are you sure?',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: kTextColor, fontSize: 18),
                                  ),
                                  actions: <Widget>[
                                    Center(
                                      child: PrimaryButton(
                                          text: 'YES',
                                          press: () {
                                            Get.back();
                                            setState(() {
                                              totalPayment = vipDances +
                                                  int.parse(tipController.text);
                                            });
                                          },
                                          width: 0.5),
                                    )
                                  ],
                                ),
                              ),
                          child: const Text(
                            'Add',
                            style: TextStyle(color: kBlackColor),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          PrimaryButton(
              text: 'Pay Vip Now',
              press: () {
                savePaymentData();
                showDialog<String>(
                  barrierColor: kSecondaryColor.withOpacity(0.7),
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: kBlackColor,
                    contentPadding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                    actionsPadding: const EdgeInsets.only(bottom: 40),
                    content: const Text(
                      'Payment Received Successfully',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kTextColor, fontSize: 18),
                    ),
                    actions: <Widget>[
                      Center(
                        child: PrimaryButton(
                            text: 'Home',
                            press: () {
                              timerController.totalAmout.value = 0;
                              timerController.numberOfSongs.value = 0;
                              timerController.time.value = '00:00:00';
                              Get.offAll(() => const HomeScreen());
                            },
                            width: 0.5),
                      )
                    ],
                  ),
                );
              },
              width: 0.6)
        ],
      ),
      bottomNavigationBar: const BottomNavBar(index: 1),
    );
  }

  Future<void> savePaymentData() async {
    try {
      if (user.id != null) {
        final payments = PaymentModel(
          userId: user.id,
          vipPayment: ' \$ ${vipDances.toString()}',
          tipPayment: ' \$ ${tipController.text}',
          totalPayment: ' \$ ${totalPayment.toString()}',
          paymentDate: '${today.month}-${today.day}-${today.year}',
        );

        await FireStoreService().addPayments(payments);
        Fluttertoast.showToast(msg: "Payment Data Saved");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

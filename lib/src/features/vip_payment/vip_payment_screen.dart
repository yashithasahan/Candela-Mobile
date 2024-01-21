import 'package:candela_maker/src/common_widgets/primary_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/bottom_nav_bar.dart';

class VIPPaymentScreen extends StatelessWidget {
  const VIPPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        foregroundColor: kTextColor,
        title: const Text(
          'VIP PAYMENT',
          style: TextStyle(
              fontFamily: "Roboto",
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 28),
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
          const TotalBox(
            width: 0.6,
            fontSize: 26,
          ),
          const SizedBox(
            height: 40,
          ),
          const PaymentBox(
            text: 'VIP',
            subText: '\$ 10',
          ),
          const PaymentBox(
            text: 'Dances',
            subText: '\$ 79',
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
                    const TotalBox(
                      width: 0.3,
                      fontSize: 16,
                    ),
                    SizedBox(
                      height: 25,
                      child: ElevatedButton(
                          onPressed: () => showDialog<String>(
                                barrierColor: kSecondaryColor.withOpacity(0.7),
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  backgroundColor: kBlackColor,
                                  contentPadding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                                  actionsPadding: const EdgeInsets.only(bottom: 40),
                                  content: const Text(
                                    '\$10 amount added as tip. Are you sure?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: kTextColor, fontSize: 18),
                                  ),
                                  actions: <Widget>[
                                    Center(
                                      child: PrimaryButton(
                                          text: 'YES',
                                          press: () {},
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
          PrimaryButton(text: 'Pay Vip Now', press: () {}, width: 0.6)
        ],
      ),
      bottomNavigationBar: const BottomNavBar(index: 0),
    );
  }
}

class TotalBox extends StatelessWidget {
  const TotalBox({
    super.key,
    required this.width,
    required this.fontSize,
  });

  final double width;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      width: size.width * width,
      decoration: BoxDecoration(
          border: Border.all(color: kTextColor),
          borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Text(
          '\$ 89',
          style: TextStyle(color: kTextColor, fontSize: fontSize),
        ),
      ),
    );
  }
}

class PaymentBox extends StatelessWidget {
  final String text;
  final String? subText;
  const PaymentBox({
    super.key,
    required this.text,
    this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 15, 40, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                    color: kTextColor, fontWeight: FontWeight.bold),
              ),
              Text(
                subText ?? '',
                style: const TextStyle(
                    color: kTextColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

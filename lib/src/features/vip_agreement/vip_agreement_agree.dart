import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../home/screens/home_screen.dart';

class VIPAgreementAgree extends StatefulWidget {
  const VIPAgreementAgree({super.key});

  @override
  State<VIPAgreementAgree> createState() => _VIPAgreementAgreeState();
}

class _VIPAgreementAgreeState extends State<VIPAgreementAgree> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: kDefaultPadding,
            child: Column(
              children: [
                const SizedBox(height: 85),
                const Text(
                  "VIP AGREEMENT",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(height: 25),
                Image.asset("assets/images/vip-agree.png"),
                const SizedBox(height: 30),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFF39D1F),
                          Color(0xFFFD8C67),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Request",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Do you agree to participate in the counting and recognition of songs?",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: kTextColor),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 65),
                PrimaryButton(
                  btnName: "Agree",
                  press: () {
                    Get.to(() => const HomeScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      
      ),
    );
  }
}

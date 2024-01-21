import 'package:candela_maker/src/common_widgets/bottom_nav_bar.dart';
import 'package:candela_maker/src/common_widgets/secondary_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';

class InsuranceScreen extends StatelessWidget {
  const InsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        foregroundColor: kTextColor,
        title: const Text(
          'Brokers Usa Insurance',
          style: TextStyle(
              fontFamily: "Roboto",
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 26),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: InsuranceBox(
                    img: 'assets/images/life-insurance.png',
                    text: 'Life Insurance',
                    press: () {},
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: InsuranceBox(
                    img: 'assets/images/medical-insurance.png',
                    text: 'Medical Insurance',
                    press: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: InsuranceBox(
                    img: 'assets/images/auto-insurance.png',
                    text: 'Auto Insurance',
                    press: () {},
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: InsuranceBox(
                    img: 'assets/images/home-insurance.png',
                    text: 'Home Insurance',
                    press: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: InsuranceBox(
                    img: 'assets/images/liability-insurance.png',
                    text: 'Liability Insurance',
                    press: () {},
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: InsuranceBox(
                    img: 'assets/images/renters-insurance.png',
                    text: 'Renters Insurance',
                    press: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: InsuranceBox(
                    img: 'assets/images/business-insurance.png',
                    text: 'Business Insurance',
                    press: () {},
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(child: Container()),
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: const BottomNavBar(index: 0),
    );
  }
}

class InsuranceBox extends StatelessWidget {
  final String img;
  final String text;
  final VoidCallback press;
  const InsuranceBox({
    super.key,
    required this.img,
    required this.text,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        const SizedBox(height: 10),
        Image.asset(
          img,
        ),
        const SizedBox(height: 5),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: SecondaryButton(text: 'Click', press: press, width: 0.3),
        )
      ]),
    );
  }
}

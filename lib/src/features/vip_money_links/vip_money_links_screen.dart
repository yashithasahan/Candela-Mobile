import 'package:candela_maker/src/common_widgets/bottom_nav_bar.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_box.dart';

class VIPMoneyLinks extends StatelessWidget {
  const VIPMoneyLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        foregroundColor: kTextColor,
        title: const Text(
          'VIP MONEY LINKS',
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
                  child: CustomBox(
                    img: 'assets/images/nft.png',
                    scale: 0.9,
                    text: 'NFTs',
                    subText: 'https://rarible.com/candelaartworks',
                    btnText: 'See More',
                    press: () {},
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CustomBox(
                    img: 'assets/images/motorcycle.png',
                    scale: 0.9,
                    text: 'Motorcycle Race Games',
                    subText: 'www.supersportracers.com',
                    btnText: 'See More',
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
                  child: CustomBox(
                    img: 'assets/images/chaos.png',
                    scale: 1,
                    text: 'Chaos X2',
                    btnText: 'See More',
                    press: () {},
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CustomBox(
                    img: 'assets/images/insurance.png',
                    scale: 1,
                    text: 'Motorcycle Race Games',
                    subText: '+1.737.341.3947',
                    btnText: 'See More',
                    press: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kTextColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shirts, Posters, Artwork',
                      style: TextStyle(
                          color: kBlackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      'www.clubcandelavip.com',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VIP Money Customer Service',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: 20),
                        Text(
                          '+1.737.297.8262',
                          style: TextStyle(
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Vipmoneyapp@gmail.com',
                          style: TextStyle(
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.web_rounded,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'www.vipmoney.app',
                          style: TextStyle(
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    
    );
  }
}


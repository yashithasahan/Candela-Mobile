import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/custom_box.dart';

class VIPMoneyLinks extends StatelessWidget {
  const VIPMoneyLinks({super.key});

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
          'vip-dance-link'.tr,
          style: const TextStyle(
              fontFamily: "Roboto",
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 26),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(size.height * 0.01),
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
                SizedBox(width: size.width * 0.05),
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
            padding: EdgeInsets.all(size.height * 0.01),
            child: Row(
              children: [
                Expanded(
                  child: CustomBox(
                    img: 'assets/images/chaos.png',
                    scale: 1,
                    text: 'Money Cannon CHAOSX2.COM',
                    btnText: 'See More',
                    press: () {},
                  ),
                ),
                SizedBox(width: size.width * 0.05),
                Expanded(
                  child: CustomBox(
                    img: 'assets/images/insurance.png',
                    scale: 1,
                    text: 'Del Castillo Insurance.com',
                    subText: '+1.737.341.3947',
                    btnText: 'See More',
                    press: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size.height * 0.01),
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
                      'WWW.CANDELAVIPSTORE.COM',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size.height * 0.01),
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

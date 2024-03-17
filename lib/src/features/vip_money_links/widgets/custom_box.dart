import 'package:flutter/material.dart';

import '../../../common_widgets/secondary_button.dart';
import '../../../constants/constants.dart';

class CustomBox extends StatelessWidget {
  final String img;
  final String text;
  final String? subText;
  final String btnText;
  final double scale;
  final VoidCallback press;
  const CustomBox({
    super.key,
    required this.img,
    required this.text,
    this.subText,
    required this.btnText,
    required this.press,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.35,
      padding: EdgeInsets.all(size.height * 0.02),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        SizedBox(height: size.height * 0.01),
        Image.asset(
          img,
          scale: scale,
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 16,
          ),
        ),
        Text(
          subText ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(color: kTextColor, fontSize: 12),
        ),
        SizedBox(height: size.height * 0.01),
        SecondaryButton(text: btnText, press: press, width: 0.3)
      ]),
    );
  }
}

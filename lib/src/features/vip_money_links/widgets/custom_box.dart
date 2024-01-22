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
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        const SizedBox(height: 10),
        Image.asset(
          img,
          scale: scale,
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
        Text(
          subText ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(color: kTextColor, fontSize: 12),
        ),
        const SizedBox(height: 10),
        SecondaryButton(text: btnText, press: press, width: 0.3)
      ]),
    );
  }
}

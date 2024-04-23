import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.press,
    required this.width,
  });
  final VoidCallback? press;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        ),
        onPressed: press,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: kBlackColor,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
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
          backgroundColor: kTextColor,
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
              fontSize: size.width * 0.035,
              color: kBlackColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

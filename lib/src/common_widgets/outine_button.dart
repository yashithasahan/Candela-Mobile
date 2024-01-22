import 'package:flutter/material.dart';
import 'package:candela_maker/src/constants/constants.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    this.icon, // Made the icon property optional
    required this.text,
    required this.press,
    required this.width,
  });

  final VoidCallback? press;
  final String text;
  final double width;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * width,
      child: OutlinedButton.icon(
        icon: icon ??
            const SizedBox.shrink(), // If icon is null, use an empty box
        label: Text(
          text,
          style: const TextStyle(
              fontSize: 12, color: kTextColor, fontWeight: FontWeight.w600),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent, // Transparent background
          side: const BorderSide(
              color: kPrimaryColor, width: 2.0), // Border color and width
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Border radius
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        ),
        onPressed: press,
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class PaymentBox extends StatelessWidget {
  final String text;
  final String? subText;
  final Widget icon;
  const PaymentBox({
    super.key,
    required this.text,
    this.subText,
    required this.icon,
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
              Row(
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                        color: kTextColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  icon,
                ],
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

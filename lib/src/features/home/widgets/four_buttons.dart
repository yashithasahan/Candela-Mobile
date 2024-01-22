import 'package:candela_maker/src/common_widgets/secondary_button.dart';
import 'package:flutter/material.dart';

class FourButtons extends StatelessWidget {
  const FourButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SecondaryButton(text: "text", press: () => {}, width: 0.3),
            SecondaryButton(text: "text", press: () => {}, width: 0.3)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SecondaryButton(text: "text", press: () => {}, width: 0.3),
            SecondaryButton(text: "text", press: () => {}, width: 0.3)
          ],
        )
      ],
    );
  }
}

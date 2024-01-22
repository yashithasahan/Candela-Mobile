import 'package:candela_maker/src/common_widgets/outine_button.dart';
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
            OutlineButton(text: "\$ 35", press: () => {}, width: 0.3),
            OutlineButton(text: "Timer ", press: () => {}, width: 0.3)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlineButton(text: "Songs", press: () => {}, width: 0.3),
            OutlineButton(text: "Total", press: () => {}, width: 0.3)
          ],
        )
      ],
    );
  }
}

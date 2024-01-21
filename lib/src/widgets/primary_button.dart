// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String btnName;
  const PrimaryButton({
    Key? key,
    required this.btnName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: Center(
        child: Container(
          width: 192,
          height: 40,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFDEA72C),
                  Color(0xFFF59C0D),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              btnName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

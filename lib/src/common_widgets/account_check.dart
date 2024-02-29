import 'package:candela_maker/src/features/authentication/register/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../features/authentication/sign_in/sign_in_screen.dart';

class AccountCheck extends StatelessWidget {
  final bool login;
  const AccountCheck({
    super.key,
    this.login = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "no-account".tr : "have-account".tr,
          style: const TextStyle(color: kTextColor),
        ),
        GestureDetector(
          onTap: () {
            login
                ? Get.to(() => const Register())
                : Get.to(() => const SignInScreen());
          },
          child: Text(
            login ? "signup".tr : "login".tr,
            style: const TextStyle(
                color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

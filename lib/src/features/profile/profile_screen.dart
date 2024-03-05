import 'package:candela_maker/src/common_widgets/primary_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/authentication/services/auth_service.dart';
import 'package:candela_maker/src/features/home/controllers/timer_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _timerController = Get.put(TimerController());

  @override
  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser!.email;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "welcome".tr,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: kPrimaryColor),
                  ),
                  Text(
                    user.toString(),
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: kPrimaryColor),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset("assets/images/vip-agree.png")),
                ],
              ),
              Text(
                "user-preferences".tr,
                style: const TextStyle(fontSize: 20, color: kPrimaryColor),
              ),
              Obx(
                () => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Expanded(
                        child: Text(
                          "set-song-count".tr,
                          style: const TextStyle(
                              fontSize: 16, color: kPrimaryColor),
                        ),
                      ),
                    ),
                    Checkbox(
                        value: _timerController.isSongCountByTime.value,
                        onChanged: (value) {
                          _timerController.isSongCountByTime.value = value!;
                        }),
                    AnimatedContainer(
                        margin: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        height:
                            _timerController.isSongCountByTime.value ? 50 : 0,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          "${'default-time'.tr} 03:30:00",
                          style: const TextStyle(
                              fontSize: 14, color: kPrimaryColor),
                        )),
                  ],
                ),
              ),
              PrimaryButton(
                  text: "logout".tr,
                  press: () => {AuthService().logout()},
                  width: 0.5),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}

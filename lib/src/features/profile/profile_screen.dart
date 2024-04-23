import 'package:candela_maker/src/common_widgets/primary_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/authentication/services/auth_service.dart';
import 'package:candela_maker/src/features/home/controllers/timer_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    Size size = MediaQuery.of(context).size;
    final user = _auth.currentUser?.email;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: size.height * 0.05),
              Text(
                "welcome".tr,
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: kPrimaryColor),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                user.toString(),
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: kPrimaryColor),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset("assets/images/vip-agree.png")),
              SizedBox(height: size.height * 0.05),
              Text(
                "user-preferences".tr,
                style: const TextStyle(fontSize: 22, color: kPrimaryColor),
              ),
              SizedBox(height: size.height * 0.03),
              Obx(
                () => SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "set-song-count".tr,
                          style: const TextStyle(
                              fontSize: 16, color: kPrimaryColor),
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
                          height: _timerController.isSongCountByTime.value
                              ? size.height * 0.14
                              : 0,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius: BorderRadius.circular(12)),
                          duration: const Duration(milliseconds: 200),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'default-time'.tr,
                                    style: const TextStyle(
                                        fontSize: 14, color: kPrimaryColor),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: kPrimaryColor,
                                      ),
                                      decoration: InputDecoration(
                                        hintText:
                                            _timerController.songTime.value,
                                        hintStyle: const TextStyle(
                                          fontSize: 16,
                                          color: kPrimaryColor,
                                        ),
                                        contentPadding: const EdgeInsets.all(8),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        _timerController.songTime.value = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "average-time".tr,
                                style: const TextStyle(color: kPrimaryColor),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              PrimaryButton(
                  text: "logout".tr,
                  press: () {
                    AuthService().logout().then((value) =>
                        Fluttertoast.showToast(msg: "Logout Successfully".tr));
                  },
                  width: 0.5),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  handleAccountDeletion();
                },
                child: Text(
                  "Delete Account".tr,
                  style: const TextStyle(color: kPrimaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleAccountDeletion() async {
    // Get.defaultDialog(
    //     title: "Account Deletion",
    //     middleText: "Are you sure you want to delete your account?",
    //     textConfirm: "Yes",
    //     textCancel: "No",
    //     onConfirm: () {
    //       AuthService().deleteAccount();
    //     });

    return showDialog<void>(
      barrierColor: kSecondaryColor.withOpacity(0.7),
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kBlackColor,
          contentPadding: const EdgeInsets.all(20),
          actionsPadding: const EdgeInsets.only(bottom: 20, right: 20),
          content: Text('Are you sure you want to delete your account?'.tr,
              style: const TextStyle(color: kTextColor, fontSize: 16)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              ),
              child: Text('no'.tr, style: const TextStyle(color: kBlackColor)),
            ),
            TextButton(
              onPressed: () {
                AuthService().deleteAccount();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              ),
              child: Text('yes'.tr, style: const TextStyle(color: kBlackColor)),
            ),
          ],
        );
      },
    );
  }
}

import 'package:candela_maker/src/common_widgets/primary_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/widgets/membership_level_btn.dart';
import 'package:candela_maker/src/widgets/membership_level_description.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/membership_controller.dart';

class MembershipLevel extends StatefulWidget {
  const MembershipLevel({super.key});

  @override
  State<MembershipLevel> createState() => _MembershipLevelState();
}

class _MembershipLevelState extends State<MembershipLevel> {
  int level = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final membershipController = Get.put(MembershipController());
    return Scaffold(
      backgroundColor: kBgColor,
      body: Padding(
        padding: kDefaultPadding,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                "MEMBERSHIP LEVEL ",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 51),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const MembershipLevelDescription(
                      description:
                          "\$10 per month- Timer & Song Count. You process your own payments."),
                  MembershipLevelButton(
                    level: 1,
                    press: () {
                      setState(() {
                        level = 1;
                        membershipController.membershipLevel.value = level;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const MembershipLevelDescription(
                      description:
                          "\$25 per month-Timer, Song Count, Realtime Onscreen / Email Report. You process your payments, we record on app transaction for you."),
                  MembershipLevelButton(
                    level: 2,
                    press: () {
                      setState(() {
                        level = 2;
                        membershipController.membershipLevel.value = level;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const MembershipLevelDescription(
                      description:
                          "\$30 per month-Timer, Song Count, Realtime Onscreen / Email Report. We process payment for additional \$5 per dance.  \$5 additional fee for every song automatically added to total.  We receive payment in crypto, credit/debit card or zelle for you and send you payment minus \$5 per song."),
                  MembershipLevelButton(
                      level: 3,
                      press: () {
                        setState(() {
                          level = 3;
                          membershipController.membershipLevel.value = level;
                        });
                      })
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const MembershipLevelDescription(
                      description:
                          " VIP MANAGER - Full Functions & Multi User Vip Manager \$500 per month for every 25 users"),
                  MembershipLevelButton(
                      level: 4,
                      press: () {
                        setState(() {
                          level = 4;
                          membershipController.membershipLevel.value = level;
                        });
                      })
                ],
              ),
              const Spacer(),
              Obx(
                () => Visibility(
                    visible: membershipController.membershipLevel.value > 0,
                    child: PrimaryButton(
                        text: 'SUBSCRIBE',
                        press: () {
                          membershipController.membershipLevel.value = level;

                          Get.back();
                        },
                        width: 0.5)),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

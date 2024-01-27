import 'package:candela_maker/src/common_widgets/primary_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/widgets/membership_level_btn.dart';
import 'package:candela_maker/src/widgets/membership_level_description.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/membership_controller.dart';

class MembershipLevel extends StatelessWidget {
  const MembershipLevel({super.key});

  @override
  Widget build(BuildContext context) {
    final membershipController = Get.put(MembershipController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        body: Padding(
          padding: kDefaultPadding,
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
                      membershipController.membershipLevel.value = 1;
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
                      membershipController.membershipLevel.value = 2;
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
                        membershipController.membershipLevel.value = 3;
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
                        membershipController.membershipLevel.value = 4;
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

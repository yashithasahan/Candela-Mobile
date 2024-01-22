import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/widgets/membership_level_btn.dart';
import 'package:candela_maker/src/widgets/membership_level_description.dart';
import 'package:flutter/material.dart';

class MembershipLevel extends StatelessWidget {
  const MembershipLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        body: Padding(
          padding: kDefaultPadding,
          child: Column(
            children: [
              SizedBox(height: 60),
              Text(
                "MEMBERSHIP LEVEL",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 51),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MembershipLevelDescription(
                      description:
                          "\$10 per month- Timer & Song Count. You process your own payments."),
                  MembershipLevelButton(level: "Level 1")
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MembershipLevelDescription(
                      description:
                          "\$25 per month-Timer, Song Count, Realtime Onscreen / Email Report. You process your payments, we record on app transaction for you."),
                  MembershipLevelButton(level: "Level 2")
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MembershipLevelDescription(
                      description:
                          "\$30 per month-Timer, Song Count, Realtime Onscreen / Email Report. We process payment for additional \$5 per dance.  \$5 additional fee for every song automatically added to total.  We receive payment in crypto, credit/debit card or zelle for you and send you payment minus \$5 per song."),
                  MembershipLevelButton(level: "Level 3")
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MembershipLevelDescription(
                      description:
                          "\ VIP MANAGER - Full Functions & Multi User Vip Manager \$500 per month for every 25 users"),
                  MembershipLevelButton(level: "Level 4")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

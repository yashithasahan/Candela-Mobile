import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../common_widgets/bottom_nav_bar.dart';
import '../../common_widgets/primary_button.dart';
import '../membership_level/controller/membership_controller.dart';
import 'vip_report_screen.dart';

class VIPReportAccess extends StatefulWidget {
  const VIPReportAccess({super.key});

  @override
  State<VIPReportAccess> createState() => _VIPReportAccessState();
}

class _VIPReportAccessState extends State<VIPReportAccess> {
  final membershipController = Get.put(MembershipController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBgColor,
        appBar: AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          centerTitle: true,
          foregroundColor: kTextColor,
          title: const Text(
            'VIP REPORT',
            style: TextStyle(
                fontFamily: "Roboto",
                color: kPrimaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 26),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Level 2-4 Required for Reports',
                style: TextStyle(color: kTextColor, fontSize: 20),
              ),
              PrimaryButton(
                  text: 'Access Reports',
                  press: () {
                    if (membershipController.membershipLevel.value >= 2) {
                      Get.to(() => const VIPReportScreen());
                    } else {
                      Fluttertoast.showToast(
                          msg: "You don't have access to this feature",
                          backgroundColor: Colors.red);
                    }
                  },
                  width: 0.6)
            ],
          ),
        ),
    );
  }
}

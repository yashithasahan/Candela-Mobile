import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

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
        title: Text(
          'vip-report'.tr,
          style: const TextStyle(
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
            Text(
              'report-alert'.tr,
              style: const TextStyle(color: kTextColor, fontSize: 20),
            ),
            PrimaryButton(
                text: 'access-reports'.tr,
                press: () {
                  if (membershipController.membershipLevel.value >= 2 ||
                      membershipController.membershipStatus.value == 'Trial') {
                    Get.to(() => const VIPReportScreen());
                  } else {
                    Fluttertoast.showToast(
                        msg: "no-acess-report".tr, backgroundColor: Colors.red);
                  }
                },
                width: 0.6)
          ],
        ),
      ),
    );
  }
}

import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../common_widgets/bottom_nav_bar.dart';
import '../../common_widgets/primary_button.dart';
import 'vip_report_screen.dart';

class VIPReportAccess extends StatefulWidget {
  const VIPReportAccess({super.key});

  @override
  State<VIPReportAccess> createState() => _VIPReportAccessState();
}

class _VIPReportAccessState extends State<VIPReportAccess> {
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
                fontSize: 28),
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
                    Get.to(() => const VIPReportScreen());
                  },
                  width: 0.6)
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar(index: 3));
  }
}

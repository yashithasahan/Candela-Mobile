import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/primary_button.dart';

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
        body: Column(
          children: [
            const Text(
              'Level 2-4 Required for Reports',
              style: TextStyle(color: kTextColor, fontSize: 20),
            ),
            PrimaryButton(text: 'Access Reports', press: () {}, width: 0.6)
          ],
        ));
  }
}

import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';

import 'widgets/report_box.dart';
import 'widgets/report_row.dart';

class VIPReportScreen extends StatefulWidget {
  const VIPReportScreen({super.key});

  @override
  State<VIPReportScreen> createState() => _VIPReportScreenState();
}

class _VIPReportScreenState extends State<VIPReportScreen> {
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
              fontSize: 26),
        ),
      ),
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const ReportBox(
                text: 'Vip Member : ',
              ),
              const ReportBox(
                text: 'Username : ',
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    'Onscreen',
                    style: TextStyle(color: kTextColor),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    height: 25,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: kBlackColor),
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 25,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'No',
                          style: TextStyle(color: kBlackColor),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    'Onscreen',
                    style: TextStyle(color: kTextColor),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    height: 25,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: kBlackColor),
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 25,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'No',
                          style: TextStyle(color: kBlackColor),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const ReportBox(
                text: 'Email : ',
                subText: 'Bcc : ',
              ),
              const ReportBox(
                text: 'Date From : ',
                subText: 'To : ',
              ),
              const ReportBox(
                text: 'Time : ',
                subText: 'To Time : ',
              ),
              const ReportBox(
                text: 'Total Transactions : ',
              ),
              const ReportBox(
                text: 'Total \$ Amount : ',
              ),
              const SizedBox(
                height: 30,
              ),
              const Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Transaction',
                        style: TextStyle(
                            color: kTextColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ReportRow(
                    text: 'Date',
                    subText: 'xx/xx/xx',
                    textColor: kTextColor,
                  ),
                  ReportRow(
                    text: 'Time',
                    subText: '00:00:00',
                    textColor: kTextColor,
                  ),
                  ReportRow(
                    text: 'Duration',
                    subText: 'xx/xx/xx',
                    textColor: kTextColor,
                  ),
                  ReportRow(
                    text: 'Vip\$',
                    subText: '\$ 10',
                    textColor: kTextColor,
                  ),
                  ReportRow(
                    text: 'Tip\$',
                    subText: '\$ 10',
                    textColor: kTextColor,
                  ),
                  ReportRow(
                    text: 'Total \$amount',
                    subText: '\$ 89',
                    textColor: kPrimaryColor,
                  ),
                  ReportRow(
                    text: 'Total Songs',
                    textColor: kPrimaryColor,
                    subText: '3',
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

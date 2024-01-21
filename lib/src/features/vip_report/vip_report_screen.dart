import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';

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
              fontSize: 28),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportRow extends StatelessWidget {
  final String text;
  final String subText;
  final Color textColor;
  const ReportRow({
    super.key,
    required this.text,
    required this.subText,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(color: textColor, fontSize: 20),
        ),
        Text(
          subText,
          style: TextStyle(color: textColor, fontSize: 20),
        ),
      ],
    );
  }
}

class ReportBox extends StatelessWidget {
  final String text;
  final String? subText;
  const ReportBox({
    super.key,
    required this.text,
    this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: kTextColor),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(color: kTextColor),
                ),
                Text(
                  subText ?? '',
                  style: const TextStyle(color: kTextColor),
                ),
              ],
            ),
          )),
    );
  }
}

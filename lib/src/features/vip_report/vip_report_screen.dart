import 'package:candela_maker/src/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/report_box.dart';
import 'widgets/report_row.dart';

class VIPReportScreen extends StatefulWidget {
  const VIPReportScreen({super.key});

  @override
  State<VIPReportScreen> createState() => _VIPReportScreenState();
}

class _VIPReportScreenState extends State<VIPReportScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DateTime today = DateTime.now();
  bool isOnScreenSelected = true;
  bool isEmailSelected = true;
  bool isLoading = true;
  String? userName;
  String? email;

  Future<void> fetchUserData() async {
    String? uid = _auth.currentUser!.uid;
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      setState(() {
        userName = userData['userName'] ?? '';
        email = userData['email'] ?? '';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        foregroundColor: kPrimaryColor,
        title: const Text(
          'VIP REPORT',
          style: TextStyle(
              fontFamily: "Roboto",
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 26),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: kPrimaryColor,
            ))
          : Padding(
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
                    ReportBox(
                      text: 'Username : $userName',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.2,
                          child: const Text(
                            'Onscreen',
                            style: TextStyle(color: kTextColor),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.25,
                        ),
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isOnScreenSelected
                                    ? kPrimaryColor
                                    : kTextColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  isOnScreenSelected = !isOnScreenSelected;
                                });
                              },
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isOnScreenSelected
                                    ? kTextColor
                                    : kPrimaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  isOnScreenSelected = !isOnScreenSelected;
                                });
                              },
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.2,
                          child: const Text(
                            'Email',
                            style: TextStyle(color: kTextColor),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.25,
                        ),
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isEmailSelected
                                    ? kPrimaryColor
                                    : kTextColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  isEmailSelected = !isEmailSelected;
                                });
                              },
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isEmailSelected
                                    ? kTextColor
                                    : kPrimaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  isEmailSelected = !isEmailSelected;
                                });
                              },
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
                    ReportBox(
                      text: 'Email : $email',
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
                    Column(
                      children: [
                        const Row(
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
                          subText: '${today.month}/${today.day}/${today.year}',
                          textColor: kTextColor,
                        ),
                        const ReportRow(
                          text: 'Time',
                          subText: '00:00:00',
                          textColor: kTextColor,
                        ),
                        const ReportRow(
                          text: 'Duration',
                          subText: 'xx/xx/xx',
                          textColor: kTextColor,
                        ),
                        const ReportRow(
                          text: 'Vip\$',
                          subText: '\$ 10',
                          textColor: kTextColor,
                        ),
                        const ReportRow(
                          text: 'Tip\$',
                          subText: '\$ 10',
                          textColor: kTextColor,
                        ),
                        const ReportRow(
                          text: 'Total \$amount',
                          subText: '\$ 89',
                          textColor: kPrimaryColor,
                        ),
                        const ReportRow(
                          text: 'Total Songs',
                          textColor: kPrimaryColor,
                          subText: '3',
                        ),
                        const SizedBox(
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

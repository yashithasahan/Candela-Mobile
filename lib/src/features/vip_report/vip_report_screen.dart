import 'package:candela_maker/src/common_widgets/primary_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/vip_report/widgets/date_time_range.dart';
import 'package:candela_maker/src/features/vip_report/widgets/song_details_box.dart';
import 'package:candela_maker/src/features/vip_report/widgets/transaction_details_box.dart';
import 'package:candela_maker/src/features/vip_report/widgets/vip_payment_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  bool isEmailSelected = false;
  bool isLoading = true;
  bool isCustomSearchActive = false;
  String? userName;
  String? email;
  int? membershipLevel;
  int totalTransactions = 0;
  int vipPaymentTotal = 0;
  int tipPaymentTotal = 0;
  int totalSongs = 0;
  int totalSongsInTransaction = 0;
  String durationInTransaction = "";
  double totalDurationSeconds = 0;
  List<dynamic> songData = [];
  List<dynamic> transactionData = [];

  String formatDuration(double totalSeconds) {
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    final int seconds =
        (totalSeconds % 60).round(); // Round to nearest whole number
    final String formattedTime = [
      if (hours > 0) hours.toString().padLeft(2, '0'),
      minutes.toString().padLeft(2, '0'),
      seconds.toString().padLeft(2, '0'),
    ].join(':');
    return formattedTime;
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true;
    });
    String? uid = _auth.currentUser!.uid;
    final DateTime startDate = vipPaymentController.getStartDate;
    final DateTime endDate = vipPaymentController.getEndDate;
    final filterdSongData = [];
    final filterdTransactionData = [];
    try {
      QuerySnapshot songSnapshot = await FirebaseFirestore.instance
          .collection("songs")
          .doc(uid)
          .collection("user_songs")
          .get();
      if (songSnapshot.docs.isNotEmpty) {
        int songCounter = 0;
        final totalSongDurationSeconds = songSnapshot.docs.map((doc) {
          final Timestamp timestamp =
              (doc.data() as Map<String, dynamic>)['songdate'];
          final DateTime songDate = timestamp.toDate();

          if (vipPaymentController.isCustomSearch.value) {
            if (songDate.isAfter(startDate) && songDate.isBefore(endDate)) {
              filterdSongData.add(doc.data());
              print(filterdSongData.length);
              songCounter++;

              final durationStr =
                  (doc.data() as Map<String, dynamic>)['duration'] as String? ??
                      "00:00.00";
              final parts = durationStr.split(':');
              final minutes = int.parse(parts[0]);
              final seconds = double.parse(parts[1]);
              return minutes * 60 + seconds; // Convert to total seconds
            } else {
              return 0.0; // Skip this song by contributing 0 to the sum
            }
          } else {
            if (songDate.isAfter(
                    DateTime.now().subtract(const Duration(days: 2))) &&
                songDate.isBefore(DateTime.now())) {
              filterdSongData.add(doc.data());
              print(filterdSongData.length);
              songCounter++;
              final durationStr =
                  (doc.data() as Map<String, dynamic>)['duration'] as String? ??
                      "00:00.00";
              final parts = durationStr.split(':');
              final minutes = int.parse(parts[0]);
              final seconds = double.parse(parts[1]);
              return minutes * 60 + seconds; // Convert to total seconds
            } else {
              return 0.0; // Skip this song by contributing 0 to the sum
            }
          }
        }).reduce((a, b) => a + b); // Sum up all durations in seconds

        setState(() {
          songData = filterdSongData;
          totalSongs = songCounter;
          totalDurationSeconds =
              totalSongDurationSeconds; // Store the total duration in seconds
        });
      }

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

      QuerySnapshot paymentSnapshot = await FirebaseFirestore.instance
          .collection("payments")
          .doc(uid)
          .collection("user_payments")
          .get();

      if (paymentSnapshot.docs.isNotEmpty) {
        // int validPaymentsCount = 0; // Initialize a counter for valid payments
        // final vipTotal = paymentSnapshot.docs.map((doc) {
        //   final Timestamp timestamp =
        //       (doc.data() as Map<String, dynamic>)['paymentDate'];
        //   final DateTime paymentDate = timestamp.toDate();

        //   if (vipPaymentController.isCustomSearch.value) {
        //     if (paymentDate.isAfter(startDate) &&
        //         paymentDate.isBefore(endDate)) {
        //       filterdTransactionData.add(doc.data());
        //       validPaymentsCount++; // Increment for each valid payment within the date range
        //       return (doc.data() as Map<String, dynamic>)['vipPayment']
        //               as num? ??
        //           0;
        //     } else {
        //       return 0; // Skip this payment by contributing 0 to the sum
        //     }
        //   } else {
        //     if (paymentDate.isAfter(
        //             DateTime.now().subtract(const Duration(days: 2))) &&
        //         paymentDate.isBefore(DateTime.now())) {
        //       filterdTransactionData.add(doc.data());
        //       validPaymentsCount++; // Increment for each valid payment within the date range
        //       return (doc.data() as Map<String, dynamic>)['vipPayment']
        //               as num? ??
        //           0;
        //     } else {
        //       return 0; // Skip this payment by contributing 0 to the sum
        //     }
        //   }
        // }).reduce((a, b) => a + b);

        // final tipTotal = paymentSnapshot.docs.map((doc) {
        //   final Timestamp timestamp =
        //       (doc.data() as Map<String, dynamic>)['paymentDate'];
        //   final DateTime paymentDate = timestamp.toDate();

        //   if (vipPaymentController.isCustomSearch.value) {
        //     if (paymentDate.isAfter(startDate) &&
        //         paymentDate.isBefore(endDate)) {
        //       return (doc.data() as Map<String, dynamic>)['tipPayment']
        //               as num? ??
        //           0;
        //     } else {
        //       return 0;
        //     }
        //   } else {
        //     return (doc.data() as Map<String, dynamic>)['tipPayment'] as num? ??
        //         0;
        //   }
        // }).reduce((a, b) => a + b);

        // setState(() {
        //   transactionData = filterdTransactionData;
        //   totalTransactions =
        //       validPaymentsCount; // Use the counted valid payments
        //   vipPaymentTotal = vipTotal.toInt();
        //   tipPaymentTotal = tipTotal.toInt();
        // });
        int validPaymentsCount = 0; // Initialize a counter for valid payments
        num vipTotal = 0;
        num tipTotal = 0;
        int totalSongsInTransaction = 0;
        String durationInTransaction = "";

        for (var doc in paymentSnapshot.docs) {
          final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          final Timestamp timestamp = data['paymentDate'];
          final DateTime paymentDate = timestamp.toDate();

          bool isWithinRange = false;

          if (vipPaymentController.isCustomSearch.value) {
            isWithinRange =
                paymentDate.isAfter(startDate) && paymentDate.isBefore(endDate);
          } else {
            isWithinRange = paymentDate.isAfter(
                    DateTime.now().subtract(const Duration(days: 2))) &&
                paymentDate.isBefore(DateTime.now());
          }

          if (isWithinRange) {
            filterdTransactionData.add(data);
            validPaymentsCount++;

            vipTotal += data['vipPayment'] as num? ?? 0;
            tipTotal += data['tipPayment'] as num? ?? 0;

            // Handle totalSongs
            if (data.containsKey('totalSongs')) {
              totalSongsInTransaction += data['totalSongs'] as int;
            }

            // Handle duration
            if (data.containsKey('duration')) {
              durationInTransaction += data['duration']
                  as String; // Or handle it according to your logic
            }
          }
        }

        setState(() {
          transactionData = filterdTransactionData;
          totalTransactions =
              validPaymentsCount; // Use the counted valid payments
          vipPaymentTotal = vipTotal.toInt();
          tipPaymentTotal = tipTotal.toInt();
          totalSongsInTransaction = totalSongsInTransaction;
          durationInTransaction = durationInTransaction;
          // Add other state updates here
        });

      }

      DocumentSnapshot memberShipSnapshot = await FirebaseFirestore.instance
          .collection("membership")
          .doc(uid)
          .get();
      if (memberShipSnapshot.exists) {
        Map<String, dynamic> memberShipData =
            memberShipSnapshot.data() as Map<String, dynamic>;

        setState(() {
          membershipLevel = memberShipData['membershipLevel'] ?? 1;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  final vipPaymentController = Get.put(VipReportController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        foregroundColor: kPrimaryColor,
        title: Text(
          'vip-report'.tr,
          style: const TextStyle(
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
                    ReportBox(
                      text:
                          '${'vip-member'.tr} : ${'level'.tr} $membershipLevel',
                    ),
                    ReportBox(
                      text: '${'username'.tr} : $userName',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.2,
                          child: Text(
                            'onscreen'.tr,
                            style: const TextStyle(color: kTextColor),
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
                              child: Text(
                                'yes'.tr,
                                style: const TextStyle(color: kBlackColor),
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
                              child: Text(
                                'no'.tr,
                                style: const TextStyle(color: kBlackColor),
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
                          child: Text(
                            'email'.tr,
                            style: const TextStyle(color: kTextColor),
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
                              child: Text(
                                'yes'.tr,
                                style: const TextStyle(color: kBlackColor),
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
                              child: Text(
                                'no'.tr,
                                style: const TextStyle(color: kBlackColor),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ReportBox(
                      text: '${'email'.tr} : $email',
                    ),
                    ReportBox(
                      text: '${'total-transactions'.tr} : $totalTransactions ',
                    ),
                    ReportBox(
                      text:
                          '${'total-amount'.tr} : ${vipPaymentTotal + tipPaymentTotal} ',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'custom-search'.tr,
                          style: const TextStyle(color: kTextColor),
                        ),
                        Checkbox(
                            activeColor: kPrimaryColor,
                            value: isCustomSearchActive,
                            onChanged: customSearchHandler),
                      ],
                    ),
                    isCustomSearchActive
                        ? DateAndTimeRangePickerForm(
                            fetchDataCallback: fetchUserData,
                          )
                        : Container(),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'transaction-summery'.tr,
                                style: const TextStyle(
                                    color: kTextColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          ReportRow(
                            text: 'from'.tr,
                            subText: vipPaymentController.isCustomSearch.value
                                ? vipPaymentController.startDate
                                    .toString()
                                    .substring(0, 16)
                                : DateTime.now()
                                    .subtract(const Duration(days: 2))
                                    .toString()
                                    .substring(0, 16),
                            textColor: kTextColor,
                          ),
                          ReportRow(
                            text: 'to'.tr,
                            subText: vipPaymentController.isCustomSearch.value
                                ? vipPaymentController.endDate
                                    .toString()
                                    .substring(0, 16)
                                : DateTime.now().toString().substring(0, 16),
                            textColor: kTextColor,
                          ),
                          ReportRow(
                            text: 'song-duration'.tr,
                            subText: formatDuration(totalDurationSeconds),
                            textColor: kTextColor,
                          ),
                          ReportRow(
                            text: 'vip\$'.tr,
                            subText: '\$ $vipPaymentTotal',
                            textColor: kTextColor,
                          ),
                          ReportRow(
                            text: 'tip\$'.tr,
                            subText: '\$ $tipPaymentTotal',
                            textColor: kTextColor,
                          ),
                          ReportRow(
                            text: 'total-amount'.tr,
                            subText: '\$ ${vipPaymentTotal + tipPaymentTotal}',
                            textColor: kPrimaryColor,
                          ),
                          ReportRow(
                            text: 'total-songs'.tr,
                            textColor: kPrimaryColor,
                            subText: '$totalSongs',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: !isCustomSearchActive,
                            child: PrimaryButton(
                                text: 'generate'.tr,
                                press: () {
                                  fetchUserData();
                                  vipPaymentController.isCustomSearch.value =
                                      false;
                                },
                                width: 0.6),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Song & transaction details'.tr,
                            style: const TextStyle(
                                color: kTextColor,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: DefaultTabController(
                              length: 2,
                              child: Column(
                                children: [
                                  TabBar(
                                    tabs: [
                                      Tab(text: "songs".tr),
                                      Tab(text: "transactions".tr),
                                    ],
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        // Your first tab content here
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.75,
                                          child: ListView.builder(
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemCount: songData.length,
                                            itemBuilder: (context, index) =>
                                                SongDetailsBox(
                                                    song: songData[index]),
                                          ),
                                        ),
                                        // Your second tab content here
                                        ListView.builder(
                                          itemCount: transactionData.length,
                                          itemBuilder: (context, index) =>
                                              TransactionDetailsBox(
                                                  index: index,
                                                  transctions:
                                                      transactionData[index]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void customSearchHandler(bool? value) {
    setState(() {
      isCustomSearchActive = value ?? false;
    });
  }
}

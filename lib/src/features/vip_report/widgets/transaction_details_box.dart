// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:candela_maker/src/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionDetailsBox extends StatelessWidget {
  final Map<String, dynamic> transctions;
  final int index;
  const TransactionDetailsBox({
    super.key,
    required this.transctions,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Destructuring the song data
    int tipPayment = transctions['tipPayment'] ?? 0;
    int vipPayment = transctions['vipPayment'] ?? 0;
    int totalSOngs = transctions['totalSongs'] ?? 0;
    String duration = transctions['duration'] ?? '00:00:00';

    Timestamp timestamp = transctions['paymentDate'] as Timestamp? ??
        Timestamp.now(); // Using a fallback to 'now' if null
    DateTime songDate = timestamp.toDate();
    TextStyle textStyle = const TextStyle(
      color: kTextColor,
    );
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kTextColor)),
      // Adjusted for visibility
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${'transation-no'.tr} ${index + 1}',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: kPrimaryColor),
          ),
          Text('${'tip-payment'.tr} \$ $tipPayment', style: textStyle),
          Text('${'vip-pay'.tr} \$ $vipPayment', style: textStyle),
          Text('${'tot-pay'.tr} \$ ${tipPayment + vipPayment}',
              style: textStyle),
          Text('${'number-of-songs'.tr}  $totalSOngs', style: textStyle),
          Text('${'total-duration'.tr}  ${duration.substring(0, 8)}',
              style: textStyle),
          Text(
              '${'date-time'.tr} ${songDate.toLocal().toString().substring(0, 16)}',
              style: textStyle), // Formatting the date to a local date string
        ],
      ),
    );
  }
}

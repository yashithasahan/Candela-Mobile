// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:candela_maker/src/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    print(transctions);
    // Destructuring the song data
    int tipPayment = transctions['tipPayment'] ?? 0;
    int vipPayment = transctions['vipPayment'] ?? 0;

    Timestamp timestamp = transctions['paymentDate'] as Timestamp? ??
        Timestamp.now(); // Using a fallback to 'now' if null
    DateTime songDate = timestamp.toDate();
    String userId = transctions['userId'] ?? 'Unknown';
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
            'Transaction No: ${index + 1}',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: kPrimaryColor),
          ),
          Text('Tip Payment:\$ $tipPayment', style: textStyle),
          Text('Vip Payment:\$ $vipPayment', style: textStyle),
          Text('Total Payment: \$ ${tipPayment + vipPayment}',
              style: textStyle),
          Text('Date & Time: ${songDate.toLocal().toString().substring(0, 16)}',
              style: textStyle), // Formatting the date to a local date string
        ],
      ),
    );
  }
}

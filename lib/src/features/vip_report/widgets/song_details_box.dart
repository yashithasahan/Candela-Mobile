import 'package:candela_maker/src/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SongDetailsBox extends StatelessWidget {
  final Map<String, dynamic> song;
  const SongDetailsBox({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    // Destructuring the song data
    String songName = song['songName'] ?? 'Unknown';
    String duration = song['duration'] ?? '00:00';
    String songArtist = song['songArtist'] ?? 'Unknown Artist';
    int songPrice = song['songPrice'] ?? 0;
    Timestamp timestamp = song['songdate'] as Timestamp? ??
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
            'Name: $songName',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: kPrimaryColor),
          ),
          Text('Artist: $songArtist', style: textStyle),
          Text('Duration: ${duration.substring(0, 6)}', style: textStyle),
          Text('Price: \$$songPrice', style: textStyle),
          Text('Date & Time: ${songDate.toLocal().toString().substring(0, 16)}',
              style: textStyle), // Formatting the date to a local date string
        ],
      ),
    );
  }
}

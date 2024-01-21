import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/home/widgets/song_card.dart';
import 'package:flutter/material.dart';

class SongList extends StatelessWidget {
  const SongList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: const [
          SongCard(
            icon: s1,
          ),
          SongCard(
            icon: s1,
          ),
          SongCard(
            icon: s1,
          ),
          SongCard(
            icon: s1,
          ),
        ],
      ),
    );
  }
}

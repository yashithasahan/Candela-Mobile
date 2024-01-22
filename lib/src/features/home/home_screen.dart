import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/home/widgets/four_buttons.dart';
import 'package:candela_maker/src/features/home/widgets/song_timer.dart';
import 'package:candela_maker/src/features/home/widgets/songs_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
          child: Column(
        children: [
          Flexible(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(mainPadding),
                child: const Stack(
                  children: [
                    FourButtons(),
                    SongTimer(),
                  ],
                ),
              )),
          Flexible(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(secondaryPadding),
                child: const SongList(),
              )),
        ],
      )),
    );
  }
}

import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/home/widgets/song_timer.dart';
import 'package:candela_maker/src/features/home/widgets/songs_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        centerTitle: true,
        foregroundColor: kTextColor,
        title: Text(
          'vip-dances'.tr,
          style: const TextStyle(
              fontFamily: "Roboto",
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 26),
        ),
      ),
      backgroundColor: kBgColor,
      body: SafeArea(
          child: Column(
        children: [
          Flexible(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(mainPadding),
                child: const Column(
                  children: [
                    SongTimer(),
                  ],
                ),
              )),
          Flexible(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(secondaryPadding),
                child: const SongList(),
              )),
        ],
      )),
    );
  }
}

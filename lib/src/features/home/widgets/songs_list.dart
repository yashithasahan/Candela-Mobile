import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/home/controllers/timer_controller.dart';
import 'package:candela_maker/src/features/home/widgets/song_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SongList extends StatefulWidget {
  const SongList({super.key});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  final timerController = Get.put(TimerController());

  imageToggle() {
    timerController.secondryCardBackgorund.value =
        !timerController.secondryCardBackgorund.value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final songList = timerController.songList;

      if (songList.isNotEmpty) {
        return ListView.builder(
          itemCount: songList.length,
          itemBuilder: (context, index) {
            return SongCard(
              song: songList[index],
              index: index,
              icon: s4,
              onTap: imageToggle,
            );
          },
        );
      } else {
        return Text(
          "no-songs".tr,
          style: const TextStyle(color: kTextColor),
        );
      }
    });
  }
}

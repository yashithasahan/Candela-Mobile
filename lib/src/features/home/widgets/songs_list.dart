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

  @override
  Widget build(BuildContext context) {
    final songList = timerController.songList.value;

    return ListView.builder(
      itemCount: songList.length,
      itemBuilder: (context, index) {
        return const SongCard(icon: s1);
      },
      
    );
 
  
  }
}

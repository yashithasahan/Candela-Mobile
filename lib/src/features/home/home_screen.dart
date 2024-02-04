import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/home/widgets/song_timer.dart';
import 'package:candela_maker/src/features/home/widgets/songs_list.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        centerTitle: true,
        foregroundColor: kTextColor,
        title: const Text(
          'VIP DANCES',
          style: TextStyle(
              fontFamily: "Roboto",
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
      ),
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
      bottomNavigationBar: const BottomNavBar(index: 0),
      resizeToAvoidBottomInset: false,
    );
  }
}

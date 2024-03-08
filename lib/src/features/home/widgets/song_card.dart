// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/home/models/song_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
    required this.icon,
    required this.index,
    required this.song,
  });
  final String icon;
  final int index;
  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: mainPadding),
      width: 100,
      height: 83,
      decoration: BoxDecoration(
          color: kSecondaryColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              icon,
              
            ),
),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${'song'.tr} # ${index + 1}",
                  style: const TextStyle(
                      fontSize: 16,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900),
                ),
         Text(
                  "unknown".tr,
                  style: const TextStyle(
                      fontSize: 10,
                      color: kTextColor,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(notes),
                  Text(
                    "\$ ${song.songPrice}",
                      style: const TextStyle(
                          fontSize: 14,
                          color: kTextColor,
                          fontWeight: FontWeight.w900),
                    ),
                  
                ],
              ),
              Container(
                width: 79,
                height: 20,
                decoration: BoxDecoration(
                    color: kTextColor, borderRadius: BorderRadius.circular(38)),
                child: Center(
                  child: Text(
                    song.duration.toString(),
                    style: const TextStyle(
                        fontSize: 10,
                        color: kBlackColor,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SongTimer extends StatelessWidget {
  const SongTimer({super.key});

  onTapStart() {
    print("starting");
  }

  onTapStop() {
    print("stoping");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: onTapStart,
                child: SvgPicture.asset(tapToStart),
              ),
            ),
            Flexible(
              flex: 7,
              child: Image.asset(
                timerMainImage,
              ),
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: onTapStop,
                child: SvgPicture.asset(tapToStop),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// SvgPicture.asset(

import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/home/controllers/timer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class SongTimer extends StatefulWidget {
  const SongTimer({super.key});

  @override
  State<SongTimer> createState() => _SongTimerState();
}

class _SongTimerState extends State<SongTimer> {
  final timerController = Get.put(TimerController());
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  int stopTime = 0;
  onTapStart() {
    _stopWatchTimer.onStartTimer();
  }

  onTapStop() {
    _stopWatchTimer.onResetTimer();
    setState(() {
      stopTime += _stopWatchTimer.rawTime.value;
    });
    timerController.numberOfSongs.value++;
    timerController.time.value =
        StopWatchTimer.getDisplayTime(stopTime, hours: false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  @override
  Widget build(BuildContext context) {
   
    
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            // image is responsive and get the possible widht without overflow
            Center(
              child: Image.asset(
                timerMainImage,
                width: size.width * 0.8,
              ),
            ),
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: 0,
              builder: (context, snap) {
                final displayTime =
                    StopWatchTimer.getDisplayTime(snap.data!, hours: false);

                return SizedBox(
                  height: size.width * 0.27,
                  child: Center(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          displayTime,
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: onTapStart,
                  child: SvgPicture.asset(
                    tapToStart,
                    width: size.width * 0.15,
                  ),
                ),
                InkWell(
                  onTap: onTapStop,
                  child: SvgPicture.asset(
                    tapToStop,
                    width: size.width * 0.15,
                  ),
                ),
              ],
            ),
          ],
        ),
        Obx(
          () => Column(
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  outlineBox(
                    null,
                    size,
                    "\$ ${timerController.amout.value}",
                  ),
                  outlineBox(
                    null,
                    size,
                    "Timer ${timerController.time.value}",
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  outlineBox(
                    null,
                    size,
                    "Total Songs ${timerController.numberOfSongs.value}",
                  ),
                  outlineBox(
                    null,
                    size,
                    "Total \$ ${timerController.numberOfSongs.value * timerController.amout.value}",
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget outlineBox(String? icon, Size size, String text) {
    return Container(
      width: size.width * 0.35,
      height: 28,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: kPrimaryColor,
          )),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        icon != null
            ? SvgPicture.asset(
                icon,
                width: size.width * 0.15,
              )
            : Container(),
        Text(
          text,
          style: const TextStyle(color: kTextColor),
        )
      ]),
    );
  }
}

// SvgPicture.asset(

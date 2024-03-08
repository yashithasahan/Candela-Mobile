import 'dart:async';

import 'package:candela_maker/src/common_widgets/primary_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/home/controllers/timer_controller.dart';
import 'package:candela_maker/src/features/home/models/song_model.dart';
import 'package:candela_maker/src/features/vip_payment/vip_payment_screen.dart';
import 'package:candela_maker/src/widgets/text_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../authentication/services/firestore_service.dart';

class SongTimer extends StatefulWidget {
  const SongTimer({super.key});

  @override
  State<SongTimer> createState() => _SongTimerState();
}

class _SongTimerState extends State<SongTimer> {
  final timerController = Get.put(TimerController());
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  Timer? _periodicTimer;
  static const int incrementDuration =
      3 * 60 * 1000 + 3 * 1000; // 3 minutes and 30 seconds in milliseconds

  int stopTime = 0;
  DateTime today = DateTime.now();
  bool isTap = false;

  onTapStart() {
    if (isTap == false) {
      _stopWatchTimer.onStartTimer();
      setState(() {
        isTap = true;
      });
    } else {
      Fluttertoast.showToast(msg: "timer-running-alert".tr);
    }
  }

  onTapStop() {
    if (isTap == true) {
      showDialog<String>(
        barrierColor: kSecondaryColor.withOpacity(0.7),
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: kBlackColor,
          contentPadding: const EdgeInsets.all(20),
          actionsPadding: const EdgeInsets.only(bottom: 20, right: 20),
          content: Text(
            'stop-timer-alert'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: kTextColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              ),
              child: Text('no'.tr, style: const TextStyle(color: kBlackColor)),
            ),
            TextButton(
              onPressed: () {
                _stopWatchTimer.onResetTimer();

                setState(() {
                  stopTime += _stopWatchTimer.rawTime.value;
                  isTap = false;
                });

                timerController.time.value =
                    StopWatchTimer.getDisplayTime(stopTime, hours: false);

                Get.back();
                _showCheckout();

                if (timerController.isSongCountByTime.value) {
                } else {
                  addSongDetails();
                  timerController.numberOfSongs.value++;
                  timerController.totalAmout.value +=
                      timerController.amout.value;
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              ),
              child: Text('yes'.tr, style: const TextStyle(color: kBlackColor)),
            ),
          ],
        ),
      );
    } else {
      Fluttertoast.showToast(msg: "start-timer-alert".tr);
    }
  }

  Future<void> _showCheckout() async {
    return showDialog<void>(
      barrierColor: kSecondaryColor.withOpacity(0.7),
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kBlackColor,
          contentPadding: const EdgeInsets.all(20),
          actionsPadding: const EdgeInsets.only(bottom: 20, right: 20),
          content: Text('to-checkout'.tr,
              style: const TextStyle(color: kTextColor, fontSize: 16)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              ),
              child: Text('no'.tr, style: const TextStyle(color: kBlackColor)),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                Get.to(() => const VIPPaymentScreen());
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              ),
              child: Text('yes'.tr, style: const TextStyle(color: kBlackColor)),
            ),
          ],
        );
      },
    );
  }

  onPriceSave(int newPrice) {
    timerController.amout.value = newPrice;
  }

  imageToggle() {
    if (kDebugMode) {
      print(timerController.secondryBackgorund.value);
    }
    timerController.secondryBackgorund.value =
        !timerController.secondryBackgorund.value;
  }

  onPriceEdit(BuildContext context, Size size) {
    final formKey = GlobalKey<FormBuilderState>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black, // Set the background color to black
      builder: (BuildContext context) {
        // Return the widget that will be displayed in the bottom sheet
        return Container(
          padding: const EdgeInsets.all(20),
          child: FormBuilder(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Make the column only as tall as its children
              children: <Widget>[
                Text("enter-price".tr,
                    style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 20),
                TextInputField(
                  value: timerController.amout.value.toString(),
                  name: "price",
                  keyboard: const TextInputType.numberWithOptions(),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryButton(
                    text: "save".tr,
                    press: () {
                      onPriceSave(int.parse(
                          formKey.currentState!.fields['price']!.value));
                      Navigator.pop(context);
                    },
                    width: 0.5,
                  ),
                ),
                const SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _checkTime() {
    int currentTime = _stopWatchTimer.rawTime.value;

    // Check if the current time has crossed a multiple of 3 minutes and 30 seconds
    if (currentTime ~/ incrementDuration >
        timerController.numberOfSongs.value) {
      // Update the number of songs and total amount
      timerController.numberOfSongs.value = currentTime ~/ incrementDuration;
      timerController.totalAmout.value =
          timerController.numberOfSongs.value * timerController.amout.value;
      addSongDetails();
    }
  }

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.setPresetTime(mSec: 0);
    if (timerController.isSongCountByTime.value) {
      _periodicTimer =
          Timer.periodic(const Duration(seconds: 1), (Timer t) => _checkTime());
    }
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
    _periodicTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                //1108 966
                GestureDetector(
                  onTap: imageToggle,
                  child: Center(
                    child: Image.asset(
                      timerController.secondryBackgorund.value
                          ? timerMainImage
                          : timerSecondImage,
                      width: timerController.secondryBackgorund.value
                          ? size.width * 0.6
                          : size.width * 0.5,
                    ),
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
                        child: Obx(
                          () => Center(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        timerController.secondryBackgorund.value
                                            ? size.height * 0.06
                                            : size.height * 0.03),
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
                        ));
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
            timerController.secondryBackgorund.value
                ? const SizedBox(
                    height: 0,
                  )
                : SizedBox(height: size.height * 0.05),
            Column(
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
                        "\$ ${timerController.amout.value.toInt()}",
                        () => onPriceEdit(context, size)),
                    outlineBox(null, size,
                        "${'timer'.tr} ${timerController.time.value}", null),
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
                        "${'total-songs'.tr} ${timerController.numberOfSongs.value}",
                        null),
                    outlineBox(
                        null,
                        size,
                        "${'total'.tr} \$ ${timerController.totalAmout.value}",
                        null),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Future<void> addSongDetails() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    User? user = auth.currentUser;
    try {
      final songs = SongModel(
        userId: user!.uid,
        songName: 'Song ${timerController.numberOfSongs.value}',
        songArtist: 'Unknown',
        songPrice: timerController.amout.value,
        duration: ' ${timerController.time.value}',
        songdate: today,
        totalSongs: '',
      );
      timerController.songList.add(songs);
      await FireStoreService().addSongs(songs, user);
      Fluttertoast.showToast(msg: "song-data-save-alert".tr);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Widget outlineBox(String? icon, Size size, String text, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width * 0.4,
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
      ),
    );
  }
}

import 'package:candela_maker/src/common_widgets/primary_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/home/controllers/timer_controller.dart';
import 'package:candela_maker/src/features/home/models/song_model.dart';
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
  int stopTime = 0;
  DateTime today = DateTime.now();
  bool isTimerRunning = false;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to stop the timer?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                _stopWatchTimer.onResetTimer();
                setState(() {
                  isTimerRunning = false;
                });
                setState(() {
                  stopTime += _stopWatchTimer.rawTime.value;
                });
                timerController.totalAmout.value += timerController.amout.value;
                timerController.numberOfSongs.value++;
                timerController.time.value =
                    StopWatchTimer.getDisplayTime(stopTime, hours: false);
                addSongDetails();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  onTapStart() {
    setState(() {
      isTimerRunning = true;
    });
    _stopWatchTimer.onStartTimer();
  }

  onTapStop() {
    if (isTimerRunning) {
      _showMyDialog();
    }
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
                const Text("Enter Price",
                    style: TextStyle(color: Colors.white)),
                TextInputField(
                  value: timerController.amout.value.toString(),
                  name: "price",
                  keyboard: const TextInputType.numberWithOptions(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryButton(
                    text: "Save",
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            //1108 966
            GestureDetector(
              onTap: imageToggle,
              child: Obx(
                () => Center(
                  child: Image.asset(
                    timerController.secondryBackgorund.value
                        ? timerMainImage
                        : timerSecondImage,
                    width: size.width * 0.6,
                  ),
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
                      "\$ ${timerController.amout.value.toInt()}",
                      () => onPriceEdit(context, size)),
                  outlineBox(
                      null, size, "Timer ${timerController.time.value}", null),
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
                      null),
                  outlineBox(null, size,
                      "Total \$ ${timerController.totalAmout.value}", null),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> addSongDetails() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    try {
      final songs = SongModel(
        userId: user!.uid,
        songName: 'Lovely',
        songArtist: 'Bille Ellish & Khalid',
        songPrice: timerController.amout.value,
        duration: ' ${timerController.time.value}',
        songdate: today,
        totalSongs: ' ${timerController.numberOfSongs.value}',
      );

      await FireStoreService().addSongs(songs, user);
      Fluttertoast.showToast(msg: "Song Data Saved");
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
      ),
    );
  }
}

// SvgPicture.asset(

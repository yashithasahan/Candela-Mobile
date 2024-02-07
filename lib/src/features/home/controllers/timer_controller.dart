import 'package:get/get.dart';

class TimerController extends GetxController {
  static TimerController get find => Get.find();

  RxString time = "00:00:00".obs;
  RxDouble amout = 25.0.obs;
  RxInt numberOfSongs = 0.obs;
  RxBool secondryBackgorund = false.obs;
  RxDouble totalAmout = 0.0.obs;
}

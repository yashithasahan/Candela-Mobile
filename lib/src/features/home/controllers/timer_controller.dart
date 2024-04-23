import 'package:candela_maker/src/features/home/models/song_model.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  static TimerController get find => Get.find();

  RxString time = "00:00:00".obs;
  RxString songTime = "03:30".obs;
  RxInt amout = 25.obs;
  RxInt numberOfSongs = 0.obs;
  RxBool secondryBackgorund = false.obs;
  RxBool secondryCardBackgorund = false.obs;
  RxInt totalAmout = 0.obs;
  RxBool isSongCountByTime = false.obs;
  RxList songList = <SongModel>[].obs;
}

import 'package:get/get.dart';

class VipReportController extends GetxController {
  static VipReportController get find => Get.find();

  // Define Rx<DateTime> objects for start and end dates.
  RxBool isCustomSearch = false.obs;
  final Rx<DateTime> startDate = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> endDate =
      Rx<DateTime>(DateTime.now().add(const Duration(days: 1)));

  // Getters to simplify access
  DateTime get getStartDate => startDate.value;
  DateTime get getEndDate => endDate.value;

  // Functions to update the dates
  void setStartDate(DateTime newStart) {
    startDate.value = newStart;
  }

  void setEndDate(DateTime newEnd) {
    endDate.value = newEnd;
  }
}

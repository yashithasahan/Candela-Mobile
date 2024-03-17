import 'package:get/get.dart';

class MembershipController extends GetxController{
  static MembershipController get find => Get.find();

  RxInt membershipLevel = 0.obs;

}
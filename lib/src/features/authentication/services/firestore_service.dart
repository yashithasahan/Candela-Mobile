import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../../home/models/song_model.dart';
import '../../membership_level/model/membership_model.dart';
import '../../vip_payment/model/payment_model.dart';
import '../models/user_model.dart';

class FireStoreService {
  final _db = FirebaseFirestore.instance;
  var logger = Logger();

  Future<void> createUser(UserModel userModel, User? user) async {
    return await _db
        .collection("users")
        .doc(user!.uid)
        .set(userModel.toJson())
        .then((value) => logger.i("User Added"))
        .catchError((e) => logger.e("Failed to add user $e"));
  }

  Future<void> addSongs(SongModel songModel, User? user) async {
    return await _db
        .collection('songs')
        .doc(user!.uid)
        .collection('user_songs')
        .add(songModel.toJson())
        .then((value) => logger.i("Song Added"))
        .catchError((error) => logger.e("Failed to add song details: $error"));
  }

  Future<void> addPayments(PaymentModel paymentModel, User? user) async {
    return await _db
        .collection('payments')
        .doc(user!.uid)
        .collection('user_payments')
        .add(paymentModel.toJson())
        .then((value) => logger.i("Payment details added"))
        .catchError((error) => logger.e("Failed to add payment details: $error"));
  }

  Future<void> addMembershipPayments(
      MembershipModel membershipModel, User? user) async {
    return await _db
        .collection('membership')
        .doc(user!.uid)
        .set(membershipModel.toJson())
        .then((value) => logger.i("Membership Payment details added"))
        .catchError((error) =>
            logger.e("Failed to add membership payment details: $error"));
  }
}

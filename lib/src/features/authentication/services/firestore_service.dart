import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../home/models/song_model.dart';
import '../../vip_payment/model/payment_model.dart';
import '../models/user_model.dart';

class FireStoreService {
  final _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel userModel, User? user) async {
    return await _db
        .collection("users")
        .doc(user!.uid)
        .set(userModel.toJson())
        .then((value) => print("User Added"))
        .catchError((e) => print("Failed to add user $e"));
  }

    Future<void> addSongs(SongModel songModel) async {
    return await _db
        .collection('songs')
        .add(songModel.toJson())
        .then((value) => print("Song details added"))
        .catchError(
            (error) => print("Failed to add song details: $error"));
  }

    Future<void> addPayments(PaymentModel paymentModel) async {
    return await _db
        .collection('payments')
        .add(paymentModel.toJson())
        .then((value) => print("Payment details added"))
        .catchError(
            (error) => print("Failed to add payment details: $error"));
  }
}

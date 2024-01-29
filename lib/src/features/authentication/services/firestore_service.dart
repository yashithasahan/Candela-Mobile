import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserInfoService {
  static final FirebaseFirestore fb = FirebaseFirestore.instance;

  ///create userInfo document with `uid`, `token`, and `phoneNumber`
  static Future<void> createUserInfo(
    UserCredential userCredential,
  ) async {
    String? token = await FirebaseMessaging.instance.getToken();
    await fb.doc('userInfo/${userCredential.user!.uid}').set(
      {
        'uid': userCredential.user!.uid,
        'token': token,
        'phoneNumber': userCredential.user!.phoneNumber,
      },
      SetOptions(merge: true),
    );
  }

  static Future<void> completeRegiration({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await fb.doc('userInfo/$uid').update(data);
  }
}

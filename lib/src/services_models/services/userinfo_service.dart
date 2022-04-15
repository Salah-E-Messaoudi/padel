import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:padel/src/services_models/firestorepath.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';

class UserInfoService {
  static final FirebaseFirestore fb = FirebaseFirestore.instance;

  ///create userInfo document with `uid`, `token`, and `phoneNumber`
  static Future<void> createUserInfo(
    UserCredential userCredential,
  ) async {
    String? token = await FirebaseMessaging.instance.getToken();
    await fb.doc(FirestorePath.userInfo(uid: userCredential.user!.uid)).set(
      {
        'uid': userCredential.user!.uid,
        'token': token,
        'phoneNumber': userCredential.user!.phoneNumber,
      },
      SetOptions(merge: true),
    );
  }

  static Future<void> completeRegiration({
    required UserData user,
    required String displayName,
    required String gender,
    required int age,
    required File image,
  }) async {
    String photoURL = await uploadImage(
      root: 'profileImages',
      imagePath: image.path,
      fileName: user.uid,
    );
    Map<String, dynamic> data = {
      'displayName': displayName,
      'gender': gender,
      'age': age,
      'photoURL': photoURL,
    };
    await AuthenticationService.updateDisplayName(displayName);
    await AuthenticationService.updatePhotoUrl(photoURL);
    await fb.doc(FirestorePath.userInfo(uid: user.uid)).update(data);
    user.completeRegiration(
      displayName,
      photoURL,
      gender,
      age,
    );
  }

  ///upload image from local storage [imagePath] with [fileName] to `cloud storage`
  static Future<String> uploadImage({
    required String imagePath,
    required String root,
    required String fileName,
  }) async {
    File file = File(imagePath);
    UploadTask uploadTask;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(root)
        .child('/' + fileName + '.png');
    uploadTask = ref.putFile(File(file.path));
    await uploadTask.whenComplete(() async {});
    return await uploadTask.snapshot.ref.getDownloadURL().then((photoURL) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        user.updatePhotoURL(photoURL);
      }
      return photoURL;
    });
  }
}

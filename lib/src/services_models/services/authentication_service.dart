import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padel/src/services_models/firestorepath.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';

class AuthenticationService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  ///subscribe to changes to the user's sign-in state (such as sign-in or sign-out)
  static Stream<UserData?> get userStream {
    return _auth.authStateChanges().asyncMap(_userFromFirebaseUser);
  }

  ///build a UserData object for current [user]
  static Future<UserData?> _userFromFirebaseUser(User? user) async {
    try {
      if (user == null) return null;
      return FirebaseFirestore.instance
          .doc(FirestorePath.userInfo(uid: user.uid))
          .get(
            const GetOptions(source: Source.server),
          )
          .then((doc) async {
        if (!doc.exists || doc.data() == null) {
          return null;
        }
        late UserData userData;
        ImageProvider<Object>? photo;
        if (user.photoURL != null) {
          photo = getCachedNetworkImageProvider(user.photoURL);
        }
        if (doc.data() != null && doc.data()!['uid'] == user.uid) {
          userData = UserData.fromUser(
            user,
            doc,
            photo,
          );
        } else {
          userData = UserData.fromUser(
            user,
            null,
            photo,
          );
        }
        return userData;
      });
    } on Exception catch (e) {
      return null;
    }
  }

  static ImageProvider<Object>? getCachedNetworkImageProvider(
      String? imagePath) {
    if (imagePath == null) return null;
    return CachedNetworkImageProvider(imagePath);
  }

  ///Signs out the current user.
  static Future<void> signOut() async {
    ListStadiumsMax.reset();
    ListBookings.reset();
    ListNotifications.reset();
    ListFriends.reset();
    ListPendingInvitations.reset();
    await _auth.signOut();
  }

  static Future<void> updateDisplayName(String displayName) async {
    var firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return;
    await firebaseUser.updateDisplayName(displayName);
  }

  static Future updatePhotoUrl(String photoURL) async {
    var firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return;
    await firebaseUser.updatePhotoURL(photoURL);
  }
}

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
      await Future.delayed(const Duration(milliseconds: 500));
      return FirebaseFirestore.instance
          .doc(FirestorePath.userInfo(uid: user.uid))
          .get(
            const GetOptions(source: Source.server),
          )
          .then((doc) async {
        if (!doc.metadata.hasPendingWrites &&
            doc.exists &&
            doc.data() != null &&
            doc.data()!['uid'] == user.uid) {
          late UserData userData;
          ImageProvider<Object>? photo;
          if (user.photoURL != null) {
            photo = getCachedNetworkImageProvider(user.photoURL);
          }
          userData = UserData.fromUser(
            user,
            doc,
            photo,
          );

          return userData;
        } else {
          await Future.delayed(const Duration(milliseconds: 500));
          return _userFromFirebaseUser(user);
        }
      });
    } catch (e) {
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
    ListStadiums.reset();
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

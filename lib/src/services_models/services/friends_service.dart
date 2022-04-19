import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padel/src/services_models/firestorepath.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:http/http.dart' as http;

class FriendsService {
  static final FirebaseFirestore fb = FirebaseFirestore.instance;

  static final httpClient = http.Client();

  static Future<Map<String, dynamic>> post(
    Uri uri,
    String data, {
    Map<String, String>? headers,
    int count = 0,
  }) async {
    http.Response response =
        await httpClient.post(uri, body: data, headers: headers);
    if (response.statusCode != 200) {
      log('Request failed: ${response.statusCode} ${response.reasonPhrase}');
      throw Exception('${response.statusCode} ${response.reasonPhrase}');
    }
    final result = jsonDecode(response.body);
    return result;
  }

  static Future<dynamic> retryFuture(
    dynamic future,
    int delay,
  ) async {
    return await Future.delayed(Duration(milliseconds: delay), () async {
      return await future();
    });
  }

  static Future<void> addFriend({
    required UserData user,
    required String phoneNumber,
    int count = 0,
  }) async {
    if (user.phoneNumber == phoneNumber) {
      throw CFException(ressult: false, code: 'invalid-phone-number');
    }
    final Uri restAPIURL = Uri.parse(
        'https://us-central1-padel-life.cloudfunctions.net/addFriend');
    Map<String, String> data = user.toUserMinString();
    data.addAll({
      'friendPhoneNumber': phoneNumber,
    });
    final result = await post(
      restAPIURL,
      jsonEncode(data),
    );
    handleResult(result);
  }

  static void handleResult(Map<String, dynamic> result, {bool showLog = true}) {
    bool? finalResult = result['result'] as bool?;
    if (finalResult == false) {
      throw CFException.fromJson(result);
    }
  }

  static Future<void> getListFriends({
    required String uid,
    required int length,
    DocumentSnapshot? afterDocument,
  }) async {
    Query query = fb
        .collection(FirestorePath.friends(uid: uid))
        .orderBy('displayName')
        .limit(length);
    if (afterDocument != null) query = query.startAfterDocument(afterDocument);
    QuerySnapshot resultquery = await query.get();
    List<Friend> list = [];
    list.addAll(resultquery.docs
        .map((doc) => Friend.fromDocumentSnapshot(doc))
        .toList());
    ListFriends.updateList(
      list,
      resultquery.docs.length == length,
      resultquery.docs.isEmpty ? null : resultquery.docs.last,
    );
  }

  static Future<void> batchDelete(List<DocumentReference> docs) async {
    WriteBatch batch = fb.batch();
    for (var doc in docs) {
      batch.delete(doc);
    }
    await batch.commit();
  }

  static Stream<bool> getNotificationBadge({required String uid}) {
    return fb
        .collection(FirestorePath.notifications(uid: uid))
        .where('seen', isEqualTo: false)
        .orderBy('createdAt')
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }
}

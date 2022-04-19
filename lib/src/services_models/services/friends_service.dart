import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padel/src/services_models/firestorepath.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';

class FriendsService {
  static final FirebaseFirestore fb = FirebaseFirestore.instance;

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

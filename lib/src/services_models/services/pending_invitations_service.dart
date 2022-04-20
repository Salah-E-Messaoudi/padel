import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padel/src/services_models/firestorepath.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';

class PendingInvitationsService {
  static final FirebaseFirestore fb = FirebaseFirestore.instance;

  static Future<void> confirm({
    required String id,
    required String uid,
    required String photoURL,
  }) async {
    await fb.doc(FirestorePath.booking(id: id)).update({
      'list_added': FieldValue.arrayUnion([uid]),
      'list_invited': FieldValue.arrayRemove([uid]),
      'list_photoURL': FieldValue.arrayUnion([photoURL]),
    });
  }

  static Future<void> ignore({
    required String id,
    required String uid,
  }) async {
    await fb.doc(FirestorePath.booking(id: id)).update({
      'list_invited': FieldValue.arrayRemove([uid]),
    });
  }

  static Future<void> getListPendingInvitations({
    required String uid,
    required int length,
    DocumentSnapshot? afterDocument,
  }) async {
    Query query = fb
        .collection(FirestorePath.bookings())
        .where('list_invited', arrayContains: uid)
        .orderBy('startAt')
        .limit(length);
    if (afterDocument != null) query = query.startAfterDocument(afterDocument);
    QuerySnapshot resultquery = await query.get();
    List<PendingInvitation> list = [];
    DateTime now = DateTime.now();
    list.addAll(resultquery.docs
        .map((doc) => PendingInvitation.fromDocumentSnapshot(doc, now))
        .toList());
    ListPendingInvitations.updateList(
      list,
      resultquery.docs.length == length,
      resultquery.docs.isEmpty ? null : resultquery.docs.last,
    );
  }

  static Stream<int> getInvitationBadge({required String uid}) {
    return fb
        .collection(FirestorePath.bookings())
        .where('list_invited', arrayContains: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }
}

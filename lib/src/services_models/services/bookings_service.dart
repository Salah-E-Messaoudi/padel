import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padel/src/services_models/firestorepath.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';

class BookingsService {
  static final FirebaseFirestore fb = FirebaseFirestore.instance;

  static Future<void> book({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    //idYYYYMMHH
    await fb
        .doc(FirestorePath.booking(id: id))
        .set(data, SetOptions(merge: false));
    if (ListBookings.isNotNull) {
      await ListBookings.refresh();
    }
  }

  static Future<void> getListBookings({
    required String uid,
    required int length,
    DocumentSnapshot? afterDocument,
  }) async {
    Query query = fb
        .collection(FirestorePath.bookings())
        // .where('chef.uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(length);
    if (afterDocument != null) query = query.startAfterDocument(afterDocument);
    QuerySnapshot resultquery = await query.get();
    List<Booking> list = [];
    DateTime now = DateTime.now();
    list.addAll(resultquery.docs
        .map((doc) => Booking.fromDocumentSnapshot(doc, now))
        .toList());
    ListBookings.updateList(
      list,
      resultquery.docs.length == length,
      resultquery.docs.isEmpty ? null : resultquery.docs.last,
    );
  }
}

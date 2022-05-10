import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padel/src/services_models/firestorepath.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';

class BookingsService {
  static final FirebaseFirestore fb = FirebaseFirestore.instance;

  static Future<void> delete({
    required DocumentReference reference,
  }) async {
    await reference.delete();
  }

  static Future<void> cancel({
    required DocumentReference reference,
  }) async {
    await reference.update({
      'canceled': true,
    });
  }

  static Future<void> book({
    required int userId,
    required int stadiumId,
    required String date,
    required String session,
    required Map<String, dynamic> data,
  }) async {
    int bookingId = await ApiCalls.createBooking(
      userId: userId,
      stadiumId: stadiumId,
      date: date,
      session: session,
    );
    data.addAll({'odooId': bookingId});
    await fb.collection(FirestorePath.bookings()).doc().set(data);
    if (ListBookings.isNotNull) {
      await ListBookings.refresh();
    }
  }

  static Future<void> inviteUser(String id, String uid) async {
    await fb.doc(FirestorePath.booking(id: id)).update({
      'list_invited': FieldValue.arrayUnion([uid]),
    });
  }

  static Future<void> getListBookings({
    required String uid,
    required int length,
    DocumentSnapshot? afterDocument,
  }) async {
    Query query = fb
        .collection(FirestorePath.bookings())
        .where('list_added', arrayContains: uid)
        // .orderBy('startAt')
        .orderBy('createdAt', descending: true)
        .limit(length);
    if (afterDocument != null) query = query.startAfterDocument(afterDocument);
    QuerySnapshot resultquery = await query.get();
    List<BookingMax> list = [];
    DateTime now = DateTime.now();
    list.addAll(resultquery.docs
        .map((doc) => BookingMax.fromDocumentSnapshot(doc, now))
        .toList());
    ListBookings.updateList(
      list,
      resultquery.docs.length == length,
      resultquery.docs.isEmpty ? null : resultquery.docs.last,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';

class ListPendingInvitations {
  static List<PendingInvitation> list = [];
  static DocumentSnapshot? lastDoc;
  static bool hasMore = false;
  static bool isNull = true;
  static bool isLoading = false;
  static late String uid;
  static const length = 8;

  static bool get isEmpty => list.isEmpty;

  static bool get isNotEmpty => list.isNotEmpty;

  static bool get isNotNull => !isNull;

  static void updateList(
    List<PendingInvitation> updatedList,
    bool updateHasMore,
    DocumentSnapshot? updateLastDoc,
  ) {
    list.addAll(updatedList);
    hasMore = updateHasMore;
    lastDoc = updateLastDoc;
    isNull = false;
    isLoading = false;
  }

  static Future<void> get() async {
    if (isNotNull || isLoading) {
      return;
    }
    list.clear();
    isLoading = true;
    await PendingInvitationsService.getListPendingInvitations(
      uid: uid,
      length: length,
    );
  }

  static Future<void> getMore({
    int? want,
  }) async {
    isLoading = true;
    await PendingInvitationsService.getListPendingInvitations(
      uid: uid,
      length: want ?? length,
      afterDocument: lastDoc,
    );
  }

  static Future<void> refresh() async {
    ListPendingInvitations.reset();
    await ListPendingInvitations.get();
  }

  static Future<bool> deleteFromList(
    PendingInvitation invitation,
  ) async {
    list.remove(invitation);
    bool oldhasMore = hasMore;
    if (hasMore) {
      await getMore(
        want: 1,
      );
    }
    return oldhasMore;
  }

  static Future<bool> deleteFromDB(
    PendingInvitation invitation,
  ) async {
    await invitation.reference.delete();
    return await deleteFromList(invitation);
  }

  static void reset() {
    isNull = true;
    isLoading = false;
  }

  static void delete() {
    list.clear();
    isNull = true;
    hasMore = false;
    lastDoc = null;
    uid = '';
  }

  static bool get canGetMore =>
      (ListPendingInvitations.isNotNull && ListPendingInvitations.hasMore);
}

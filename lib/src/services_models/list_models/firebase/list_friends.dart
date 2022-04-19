import 'package:padel/src/services_models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padel/src/services_models/services.dart';

class ListFriends {
  static List<Friend> list = [];
  static DocumentSnapshot? lastDoc;
  static bool hasMore = false;
  static bool isNull = true;
  static bool isLoading = false;
  static late String uid;
  static const length = 12;

  static bool get isEmpty => list.isEmpty;

  static bool get isNotNull => !isNull;

  static void updateList(
    List<Friend> updatedList,
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
    await FriendsService.getListFriends(
      uid: uid,
      length: length,
    );
  }

  static Future<void> getMore({
    int? want,
  }) async {
    isLoading = true;
    await FriendsService.getListFriends(
      uid: uid,
      length: want ?? length,
      afterDocument: lastDoc,
    );
  }

  static Future<void> refresh() async {
    ListFriends.reset();
    await ListFriends.get();
  }

  static Future<bool> deleteFromList(
    Friend friend,
  ) async {
    list.remove(friend);
    bool oldhasMore = hasMore;
    if (hasMore) {
      await getMore(
        want: 1,
      );
    }
    return oldhasMore;
  }

  static Future<bool> deleteFromDB(
    Friend friend,
  ) async {
    friend.delete();
    return await deleteFromList(friend);
  }

  static void insert(Friend friend) {
    list.insert(0, friend);
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

  static bool get canGetMore => (ListFriends.isNotNull && ListFriends.hasMore);
}

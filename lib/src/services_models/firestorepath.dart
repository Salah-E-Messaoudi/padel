class FirestorePath {
  static String userInfos() => 'userInfo/';
  static String userInfo({required String? uid}) => 'userInfo/$uid';

  static String notifications({required String uid}) =>
      'userInfo/$uid/notifications/';
  static String notification({
    required String uid,
    required String id,
  }) =>
      'userInfo/$uid/notifications/$id';

  static String bookings() => 'bookings/';
  static String booking({required String? id}) => 'bookings/$id';
}

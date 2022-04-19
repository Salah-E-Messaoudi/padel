import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:padel/functions.dart';

class BookingMin {
  BookingMin({
    required this.startAt,
    required this.endAt,
    required this.active,
    required this.listphotoURL,
  });

  final DateTime startAt;
  final DateTime endAt;
  final bool active;
  final List<ImageProvider<Object>> listphotoURL;

  factory BookingMin.fromMap(
    Map<String, dynamic> json,
    DateTime now,
  ) {
    return BookingMin(
      startAt: getDateTime(json['startAt'])!,
      endAt: getDateTime(json['endAt'])!,
      active: getDateTime(json['endAt'])!.isAfter(now),
      listphotoURL: List<String>.from(json['list_photoURL'])
          .map((e) => CachedNetworkImageProvider(e))
          .toList(),
    );
  }

  int get teamCount => listphotoURL.length;
}

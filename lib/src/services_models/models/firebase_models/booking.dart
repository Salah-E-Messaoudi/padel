import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padel/functions.dart';

class Booking {
  Booking({
    required this.displayName,
    required this.address,
    required this.description,
    required this.price,
    required this.type,
    required this.photoUrl,
    required this.photo,
    required this.createdAt,
    required this.startAt,
    required this.endAt,
    required this.booked,
    required this.status,
    required this.reference,
  });

  final String displayName;
  final String address;
  final String description;
  final double price;
  final String type;
  final String photoUrl;
  final ImageProvider<Object>? photo;
  final DateTime createdAt;
  final DateTime startAt;
  final DateTime endAt;
  final int booked;
  final bool status;
  final DocumentReference reference;

  factory Booking.fromDocumentSnapshot(
    DocumentSnapshot doc,
    DateTime now,
  ) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Booking(
      displayName: json['displayName'],
      address: json['address'],
      description: json['description'],
      price: json['price'].toDouble(),
      type: json['type'],
      photoUrl: json['photoURL'],
      booked: json['booked'].toInt(),
      createdAt: getDateTime(json['createdAt'])!,
      startAt: getDateTime(json['startAt'])!,
      endAt: getDateTime(json['endAt'])!,
      status: getDateTime(json['startAt'])!.isAfter(now),
      reference: doc.reference,
      photo: CachedNetworkImageProvider(json['photoURL'] as String),
    );
  }
}

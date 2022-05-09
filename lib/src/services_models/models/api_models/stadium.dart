import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Stadium {
  Stadium({
    required this.id,
    required this.name,
    required this.address,
    required this.note,
    required this.price,
    required this.type,
    required this.photoUrl,
    required this.photo,
  });

  final int id;
  final String name;
  final String? address;
  final String note;
  final double price;
  final String? type;
  final String? photoUrl;
  final ImageProvider<Object>? photo;

  factory Stadium.fromMap(
    Map<String, dynamic> json,
  ) {
    String? url = json['photoURL'] is String ? json['photoURL'] : null;
    return Stadium(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      note: json['note'],
      price: json['price'].toDouble(),
      type: json['type'],
      photoUrl: url,
      photo: url != null
          ? CachedNetworkImageProvider(json['photoURL'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'note': note,
        'price': price,
        'type': type,
        'photoURL': photoUrl,
      };
}

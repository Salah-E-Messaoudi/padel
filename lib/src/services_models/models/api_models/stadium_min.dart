import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StadiumMin {
  StadiumMin({
    required this.displayName,
    required this.address,
    required this.description,
    required this.price,
    required this.type,
    required this.photoUrl,
    required this.photo,
  });

  final String displayName;
  final String address;
  final String description;
  final double price;
  final String type;
  final String photoUrl;
  final ImageProvider<Object>? photo;

  factory StadiumMin.fromMap(
    Map<String, dynamic> json,
  ) =>
      StadiumMin(
        displayName: json['displayName'],
        address: json['address'],
        description: json['description'],
        price: json['price'].toDouble(),
        type: json['type'],
        photoUrl: json['photoURL'],
        photo: CachedNetworkImageProvider(json['photoURL'] as String),
      );

  Map<String, dynamic> toMap() => {
        'displayName': displayName,
        'address': address,
        'description': description,
        'price': price,
        'type': type,
        'photoUrl': photoUrl,
      };
}

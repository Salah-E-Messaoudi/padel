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
    ImageProvider<Object>? image,
  ) =>
      StadiumMin(
        displayName: json['displayName'],
        address: json['address'],
        description: json['description'],
        price: json['price'].toDouble(),
        type: json['type'],
        photoUrl: json['photoURL'],
        photo: image,
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

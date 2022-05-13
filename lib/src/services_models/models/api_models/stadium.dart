import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:padel/src/services_models/services.dart';

class Stadium {
  Stadium({
    required this.id,
    required this.name,
    required this.address,
    required this.note,
    required this.price,
    required this.type,
    required this.avatar,
    required this.avatarBase64,
  });

  final int id;
  final String name;
  final String? address;
  final String? note;
  final double price;
  final String type;
  final ImageProvider<Object>? avatar;
  final String? avatarBase64;
  Set<ImageProvider<Object>>? images;

  factory Stadium.fromMap(
    Map<String, dynamic> json,
    String? address,
    String type,
  ) {
    String? avatarBase64 = json['image'] is String ? json['image'] : null;
    return Stadium(
      id: json['id'],
      name: json['name'],
      address: address,
      note: json['note'],
      price: json['price'].toDouble(),
      type: type,
      avatar: avatarBase64 != null
          ? Image.memory(base64.decode(avatarBase64)).image
          : null,
      avatarBase64: avatarBase64,
    );
  }

  factory Stadium.fromFullMap(
    Map<String, dynamic> json,
  ) {
    String? avatarBase64 = json['avatar'] is String ? json['avatar'] : null;
    return Stadium(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      note: json['note'],
      price: json['price'].toDouble(),
      type: json['type'],
      avatar: avatarBase64 != null
          ? Image.memory(base64.decode(avatarBase64)).image
          : null,
      avatarBase64: avatarBase64,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'note': note,
        'price': price,
        'type': type,
        'avatar': avatarBase64,
      };

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64.decode(base64String));
  }

  Future<void> updateImage() async {
    images = await ApiCalls.getImagesForStadiumById(id);
  }
}

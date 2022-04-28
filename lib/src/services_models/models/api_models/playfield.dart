import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlayField {
  PlayField({
    required this.id,
    required this.displayName,
    required this.name,
    required this.duration,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.note,
    required this.image1920,
    required this.image1024,
    required this.image512,
    required this.image256,
    required this.image128,
  });

  final int id;
  final String displayName;
  final String name;
  final int duration;
  final int startTime;
  final int endTime;
  final double price;
  final String note;
  final ImageProvider<Object>? image1920;
  final ImageProvider<Object>? image1024;
  final ImageProvider<Object>? image512;
  final ImageProvider<Object>? image256;
  final ImageProvider<Object>? image128;

  factory PlayField.fromMap(Map<String, dynamic> json) => PlayField(
        id: json['id'],
        displayName: json['display_name'],
        name: json['name'],
        duration: json['duration'],
        startTime: json['start_time'],
        endTime: json['end_time'],
        price: json['price'].toDouble(),
        note: json['note'],
        image1920: json['image_1920'] == null
            ? null
            : CachedNetworkImageProvider(json['image_1920']),
        image1024: json['image_1024'] == null
            ? null
            : CachedNetworkImageProvider(json['image_1024']),
        image512: json['image_512'] == null
            ? null
            : CachedNetworkImageProvider(json['image_512']),
        image256: json['image_256'] == null
            ? null
            : CachedNetworkImageProvider(json['image_256']),
        image128: json['image_128'] == null
            ? null
            : CachedNetworkImageProvider(json['image_128']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'display_name': displayName,
        'name': name,
        'duration': duration,
        'start_time': startTime,
        'end_time': endTime,
        'price': price,
        'note': note,
        'image_1920': image1920,
        'image_1024': image1024,
        'image_512': image512,
        'image_256': image256,
        'image_128': image128,
      };
}

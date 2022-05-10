import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:padel/src/services_models/models.dart';

class Game {
  Game({
    required this.id,
    required this.type,
    required this.grounds,
  });

  final int id;
  final String type;
  final List<Ground> grounds;

  factory Game.fromMap(Map<String, dynamic> json) => Game(
        id: json['id'],
        type: json['name'],
        grounds: json['grounds'] == null
            ? []
            : List<Ground>.from(
                json['grounds'].map(
                  (x) => Ground.fromMap(
                    x,
                    json['name'], //type = name from grame
                  ),
                ),
              ),
      );
}

class Ground {
  Ground({
    required this.id,
    required this.name,
    required this.stadiums,
  });

  final int id;
  final String name;
  final List<Stadium> stadiums;

  factory Ground.fromMap(Map<String, dynamic> json, String type) => Ground(
        id: json['id'],
        name: json['name'],
        stadiums: List<Stadium>.from(
          json['stadium'].map(
            (x) => Stadium.fromMap(
              x,
              json['name'], // address = name of compound
              type,
            ),
          ),
        ),
      );
}

// class PlayField {
//   PlayField({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.price,
//     required this.note,
//   });

//   final int id;
//   final String name;
//   final ImageProvider<Object>? image;
//   final double price;
//   final String note;

//   factory PlayField.fromMap(Map<String, dynamic> json) => PlayField(
//         id: json['id'],
//         name: json['name'],
//         image: json['image'] != null
//             ? Image.memory(base64.decode(json['image'])).image
//             : null,
//         price: json['price'],
//         note: json['note'],
//       );
// }

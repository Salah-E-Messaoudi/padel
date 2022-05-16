import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  static const String _token =
      'cHJvZHVjdGlvbjo3NTdiY2FmMy03M2U3LTQzZjktYjdiZi1jOTE5Y2E5ZmY2NGI=';
  static const String _baseurl = 'https://mla3b-q8.alhayat.sa';
  // 'https://mla3b-q8-test.alhayat.sa';

  static Future<List<Stadium>> getListStadiums() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Basic $_token',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request('PATCH',
        Uri.parse('$_baseurl/api/v1/booking/fms.booking/call/get_stadiums'));
    request.body = json.encode({'args': []});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(await response.stream.bytesToString());
      return results
          .map((e) => Stadium.fromMap(
                e,
                null,
                'PADEL',
              ))
          .toList();
    } else {
      log(response.reasonPhrase.toString());
      throw Exception();
    }
  }

  static Future<List<Game>> getListGames() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Basic $_token',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request(
      'PATCH',
      Uri.parse(
        '$_baseurl/api/v1/booking/fms.booking/call/get_game_tree',
      ),
    );
    request.body = json.encode({'args': []});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(await response.stream.bytesToString());
      return results.map((e) => Game.fromMap(e)).toList();
    } else {
      log(response.reasonPhrase.toString());
      throw Exception();
    }
  }

  static Future<Stadium> getStadiumById(int id) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Basic $_token',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request('PATCH',
        Uri.parse('$_baseurl/api/v1/booking/fms.booking/call/get_stadiums'));
    request.body = json.encode({
      'args': [id]
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(await response.stream.bytesToString());
      return Stadium.fromMap(
        results.first,
        null,
        '',
      );
    } else {
      log(response.reasonPhrase.toString());
      throw Exception();
    }
  }

  static Future<Set<ImageProvider<Object>>> getImagesForStadiumById(
      int id) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Basic $_token',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request('PATCH',
        Uri.parse('$_baseurl/api/v1/booking/fms.booking/call/get_stadiums'));
    request.body = json.encode({
      'args': [id]
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(await response.stream.bytesToString());
      if (results.isEmpty) return {};
      Set<ImageProvider<Object>> images = {};
      Map<String, dynamic> json = results.first;
      addImageToSet(images, json['image']);
      if (json['image_ids'] is List<dynamic>) {
        var listImages = json['image_ids'] as List<dynamic>;
        for (var element in listImages) {
          addImageToSet(images, element['image_1920']);
        }
      }
      return images;
    } else {
      log(response.reasonPhrase.toString());
      throw Exception();
    }
  }

  static ImageProvider<Object>? getImageFromDynamic(dynamic imageBase64) {
    return imageBase64 is String
        ? Image.memory(base64.decode(imageBase64)).image
        : null;
  }

  static void addImageToSet(
    Set<ImageProvider<Object>?> set,
    dynamic imageBase64,
  ) {
    ImageProvider<Object>? image = getImageFromDynamic(imageBase64);
    if (image != null) {
      set.add(image);
    }
  }

  static Future<List<AvailibilitySlot>> getAvailableSlots(
    int stadiumId,
    String date,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Basic $_token',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request('PATCH',
        Uri.parse('$_baseurl/api/v1/booking/fms.booking/call/available_slots'));
    request.body = json.encode({
      'args': [stadiumId, date]
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(await response.stream.bytesToString());
      return results.map((e) => AvailibilitySlot.fromMap(e)).toList();
    } else {
      log(response.reasonPhrase.toString());
      throw Exception();
    }
  }

  static Future<int> memberCreate({
    required String displayName,
    required String gender,
    required String phoneNumber,
    required String birthDate,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Basic $_token',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request(
      'PATCH',
      Uri.parse(
        '$_baseurl/api/v1/booking/fms.booking/call/api_member_create',
      ),
    );
    request.body = json.encode({
      'args': [
        displayName,
        gender,
        birthDate,
        phoneNumber,
        '',
        {'street': 'street 1', 'zip': '11223', 'city': 'LHR'}
      ]
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(await response.stream.bytesToString());
      return results.first;
    } else if (response.statusCode == 500) {
      log(response.reasonPhrase.toString());
      throw APIException.fromJson(
        jsonDecode(await response.stream.bytesToString()),
      );
    } else {
      log(response.reasonPhrase.toString());
      throw Exception();
    }
  }

  static Future<int> createBooking({
    required int userId,
    required int stadiumId,
    required String date,
    required String session,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Basic $_token',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request(
      'PATCH',
      Uri.parse(
        '$_baseurl/api/v1/booking/fms.booking/call/api_create',
      ),
    );
    request.body = json.encode({
      'args': [
        userId,
        stadiumId,
        date,
        session,
      ]
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> result =
          jsonDecode(await response.stream.bytesToString());
      return result['id'];
    } else if (response.statusCode == 500) {
      log(response.reasonPhrase.toString());
      throw APIException.fromJson(
        jsonDecode(await response.stream.bytesToString()),
      );
    } else {
      log(response.reasonPhrase.toString());
      throw Exception();
    }
  }

  static Future<void> cancelBooking({
    required int bookingId,
    required String why,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Basic $_token',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request(
        'PATCH',
        Uri.parse(
            '$_baseurl/api/v1/booking/fms.booking/call/api_cancel_booking'));
    request.body = json.encode({
      'args': [
        bookingId,
        why,
      ]
    });
    request.headers.addAll(headers);
    await request.send();
  }

  static Future<void> updateProfile({
    required int userId,
    required String displayName,
    required String gender,
    required String birthDate,
    required File? image,
  }) async {
    String? imageBase64;
    if (image != null) {
      List<int> imageBytes = image.readAsBytesSync();
      imageBase64 = base64Encode(imageBytes);
    }
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Basic $_token',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request(
        'PATCH',
        Uri.parse(
            '$_baseurl/api/v1/booking/fms.booking/call/api_update_profile'));
    request.body = json.encode({
      'args': [
        {
          'id': userId.toString(),
          'name': displayName,
          'gender': gender,
          'birthday': birthDate,
          if (imageBase64 != null) 'image_1920': imageBase64,
        }
      ]
    });
    request.headers.addAll(headers);
    await request.send();
  }
}

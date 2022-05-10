import 'dart:convert';

import 'package:padel/src/services_models/models.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  static const String _token =
      'bWxhM2ItcTgtdGVzdC1hcGk6Zjc4YzQ2MzItYTMwMS00YjQwLTg4NmQtMDZhZmIyOWU2ODQx';

  static Future<List<Stadium>> getListStadiums() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Basic $_token',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request(
        'PATCH',
        Uri.parse(
            'https://mla3b-q8-test.alhayat.sa/api/v1/booking/fms.booking/call/get_stadiums'));
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
      // log(response.reasonPhrase.toString());
      throw Exception();
    }
  }

  static Future<List<Game>> getListGames() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic bWxhM2ItcTgtdGVzdC1hcGk6Zjc4YzQ2MzItYTMwMS00YjQwLTg4NmQtMDZhZmIyOWU2ODQx',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request(
      'PATCH',
      Uri.parse(
        'https://mla3b-q8-test.alhayat.sa/api/v1/booking/fms.booking/call/get_game_tree',
      ),
    );
    request.body = json.encode({'args': []});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(await response.stream.bytesToString());
      return results.map((e) => Game.fromMap(e)).toList();
    } else {
      // log(response.reasonPhrase.toString());
      throw Exception();
    }
  }

  static Future<Stadium> getStadiumById(int id) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic bWxhM2ItcTgtdGVzdC1hcGk6Zjc4YzQ2MzItYTMwMS00YjQwLTg4NmQtMDZhZmIyOWU2ODQx',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request(
        'PATCH',
        Uri.parse(
            'https://mla3b-q8-test.alhayat.sa/api/v1/booking/fms.booking/call/get_stadiums'));
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
      // log(response.reasonPhrase.toString());
      throw Exception();
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
    var request = http.Request(
        'PATCH',
        Uri.parse(
            'https://mla3b-q8-test.alhayat.sa/api/v1/booking/fms.booking/call/available_slots'));
    request.body = json.encode({
      'args': [stadiumId, date]
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(await response.stream.bytesToString());
      return results.map((e) => AvailibilitySlot.fromMap(e)).toList();
    } else {
      // log(response.reasonPhrase.toString());
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
      'Authorization':
          'Basic bWxhM2ItcTgtdGVzdC1hcGk6Zjc4YzQ2MzItYTMwMS00YjQwLTg4NmQtMDZhZmIyOWU2ODQx',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request(
      'PATCH',
      Uri.parse(
        'https://mla3b-q8-test.alhayat.sa/api/v1/booking/fms.booking/call/api_member_create',
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
      // log(response.reasonPhrase.toString());
      // log(jsonDecode(await response.stream.bytesToString()).toString());
      throw APIException.fromJson(
        jsonDecode(await response.stream.bytesToString()),
      );
    } else {
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
      'Authorization':
          'Basic bWxhM2ItcTgtdGVzdC1hcGk6Zjc4YzQ2MzItYTMwMS00YjQwLTg4NmQtMDZhZmIyOWU2ODQx',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request(
      'PATCH',
      Uri.parse(
        'https://mla3b-q8-test.alhayat.sa/api/v1/booking/fms.booking/call/api_create',
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
      // log(response.reasonPhrase.toString());
      // log(jsonDecode(await response.stream.bytesToString()).toString());
      throw APIException.fromJson(
        jsonDecode(await response.stream.bytesToString()),
      );
    } else {
      throw Exception();
    }
  }

  static Future<void> cancelBooking({
    required int bookingId,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic bWxhM2ItcTgtdGVzdC1hcGk6Zjc4YzQ2MzItYTMwMS00YjQwLTg4NmQtMDZhZmIyOWU2ODQx',
      'Cookie': 'session_id=92779ab806956e60b21d00448287f84af02c921f'
    };
    var request = http.Request(
        'PATCH',
        Uri.parse(
            'https://mla3b-q8-test.alhayat.sa/api/v1/booking/fms.booking/call/api_cancel_booking'));
    request.body = json.encode({
      'args': [
        bookingId,
      ]
    });
    request.headers.addAll(headers);
    // http.StreamedResponse response =
    await request.send();
    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
  }
}

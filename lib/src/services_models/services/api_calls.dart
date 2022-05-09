import 'dart:convert';
import 'dart:developer';

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
      log('request done...');
      return results.map((e) => Stadium.fromMap(e)).toList();
    } else {
      log(response.reasonPhrase.toString());
      throw Exception();
    }
  }

  static Future<List<AvailibilitySlot>> getAvailableSlots(
      int stadiumId, String date) async {
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
      log(response.reasonPhrase.toString());
      throw Exception();
    }
  }
}

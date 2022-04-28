import 'dart:convert';
import 'dart:developer';

import 'package:padel/src/services_models/models.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  static const String _token =
      'bWxhM2ItcTgtdGVzdC1hcGk6ZjliOWIzNmQtNDA2My00ODIyLWEyMzktOTMyOTk1Yjg5Zjc4';

  static final httpClient = http.Client();
  //server uri
  static const String _baseurl = 'https://mla3b-q8-test.alhayat.sa';

  static Map<String, String> get getHeaders => {
        'Authorization': 'Basic $_token',
        'Accept': 'application/json',
      };

  static Map<String, String> get postHeaders => {
        'Authorization': 'Basic $_token',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  //parameters for Failures
  static const int nbretry = 5;
  static const int delay = 300;

  static Future<Map<String, dynamic>> post(
    Uri uri,
    Map<String, String> data, {
    Map<String, String>? headers,
    int count = 0,
  }) async {
    try {
      http.Response response =
          await httpClient.post(uri, body: data, headers: headers);
      if (response.statusCode != 200) {
        log('Request failed: ${response.statusCode} ${response.reasonPhrase}');
        throw Exception('${response.statusCode} ${response.reasonPhrase}');
      }
      final result = jsonDecode(response.body);
      log('Attemp success');
      return result;
    } on Exception catch (e) {
      if (count < nbretry) {
        log('Failed, retrying...Attemp N°${count + 1}');
        return await retryFuture(
            () => post(uri, data, headers: headers, count: count + 1), delay);
      }
      log('Terminated');
      log(e.toString());
      rethrow;
    }
  }

  static Future<dynamic> get(
    Uri uri, {
    Map<String, String>? headers,
    int count = 0,
  }) async {
    try {
      log(uri.host + uri.path);
      log(headers.toString());
      http.Response response = await httpClient.get(uri, headers: headers);
      if (response.statusCode != 200) {
        log('Request failed: ${response.statusCode} ${response.reasonPhrase}');
        throw Exception('${response.statusCode} ${response.reasonPhrase}');
      }
      final result = jsonDecode(response.body);
      log('Attemp success');
      return result;
    } on Exception catch (e) {
      if (count < nbretry) {
        log('Failed, retrying...Attemp N°${count + 1}');
        return await retryFuture(
            () => get(uri, headers: headers, count: count + 1), delay);
      }
      log('Terminated');
      log(e.toString());
      rethrow;
    }
  }

  static Future<dynamic> retryFuture(
    dynamic future,
    int delay,
  ) async {
    return await Future.delayed(Duration(milliseconds: delay), () async {
      return await future();
    });
  }

  static void handleResult(Map<String, dynamic> result, {bool showLog = true}) {
    try {
      final String? error = result['error'];
      if (error != null) {
        throw APIException.fromJson(result);
      }
    } on APIException catch (e) {
      if (showLog) {
        log(e.error_descrip);
      }
      rethrow;
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  static Future<void> getAPIListStadiums() async {
    final Uri restAPIURL = Uri.parse('$_baseurl/api/v1/playfields/play.field');
    final response = await get(
      restAPIURL,
      headers: getHeaders,
    );
    log(response.toString());
    handleResult(response);
  }

  static Future<void> getAPIStadium(String id) async {
    final Uri restAPIURL =
        Uri.parse('$_baseurl/api/v1/playfields/play.field/$id');
    final response = await get(
      restAPIURL,
      headers: getHeaders,
    );
    log(response.toString());
    handleResult(response);
  }

  static Future<List<StadiumMax>> getListStadiums(String type) async {
    await Future.delayed(const Duration(seconds: 2));
    var stadium = StadiumMax.fromMap(
      {
        'id': 'GHTXYYTZA',
        'displayName': 'Dalton Mckee',
        'address': '254 Lee Avenue, Leland, South Dakota, 2583',
        'description':
            'Consectetur sint sunt in elit laboris id pariatur est mollit duis ipsum ea excepteur. Pariatur culpa tempor anim adipisicing qui do exercitation.',
        'price': 15.3,
        'type': 'padel',
        'photoURL':
            'https://www.integralturf.com/wp-content/uploads/2021/09/padel-tennis-court.jpg',
        'availibility': [
          {
            'availableOn': '2022-04-16T11:30:43.965Z',
            'availableAt': [
              {
                'startAt': '2022-04-16T08:00:43.965Z',
                'endAt': '2022-04-16T11:09:00.965Z'
              },
              {
                'startAt': '2022-04-16T09:00:43.965Z',
                'endAt': '2022-04-16T11:10:00.965Z'
              },
              {
                'startAt': '2022-04-16T11:00:00.965Z',
                'endAt': '2022-04-16T12:00:43.965Z'
              }
            ]
          },
          {
            'availableOn': '2022-05-27T00:00:43.965Z',
            'availableAt': [
              {
                'startAt': '2022-05-27T08:00:43.965Z',
                'endAt': '2022-05-27T09:00:43.965Z'
              },
              {
                'startAt': '2022-05-27T09:00:43.965Z',
                'endAt': '2022-05-27T10:00:43.965Z'
              },
              {
                'startAt': '2022-05-27T10:00:43.965Z',
                'endAt': '2022-05-27T11:00:43.965Z'
              }
            ]
          },
          {
            'availableOn': '2022-01-27T11:30:43.965Z',
            'availableAt': [
              {
                'startAt': '2022-01-27T11:30:43.965Z',
                'endAt': '2022-01-27T11:30:43.965Z'
              },
              {
                'startAt': '2022-01-27T11:30:43.965Z',
                'endAt': '2022-01-27T11:30:43.965Z'
              },
              {
                'startAt': '2022-01-27T11:30:43.965Z',
                'endAt': '2022-01-27T11:30:43.965Z'
              }
            ]
          }
        ]
      },
    );
    return [
      stadium,
      stadium,
      stadium,
      stadium,
      stadium,
      stadium,
      stadium,
      stadium,
      stadium,
    ];
  }
}

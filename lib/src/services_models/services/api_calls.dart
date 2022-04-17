import 'package:padel/src/services_models/models.dart';

class ApiCalls {
  static Future<List<StadiumMax>> getListStadiums(String type) async {
    await Future.delayed(const Duration(seconds: 2));
    var stadium = StadiumMax.fromMap(
      {
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

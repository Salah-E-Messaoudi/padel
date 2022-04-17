import 'package:flutter/material.dart';
import 'package:padel/src/services_models/models.dart';

class StadiumMax {
  StadiumMax({
    required this.stadium,
    required this.availibility,
  });

  final StadiumMin stadium;
  final List<AvailibilityDay> availibility;

  factory StadiumMax.fromMap(
    Map<String, dynamic> json,
    ImageProvider<Object>? image,
  ) =>
      StadiumMax(
        stadium: StadiumMin.fromMap(json, image),
        availibility: List<AvailibilityDay>.from(
            json['availibility'].map((x) => AvailibilityDay.fromMap(x))),
      );
}

class AvailibilityDay {
  AvailibilityDay({
    required this.availableOn,
    required this.availableAt,
  });

  final DateTime availableOn;
  final List<AvailibilityHour> availableAt;

  factory AvailibilityDay.fromMap(Map<String, dynamic> json) => AvailibilityDay(
        availableOn: DateTime.parse(json['availableOn']),
        availableAt: List<AvailibilityHour>.from(
            json['availableAt'].map((x) => AvailibilityHour.fromMap(x))),
      );
}

class AvailibilityHour {
  AvailibilityHour({
    required this.startAt,
    required this.endAt,
  });

  final DateTime startAt;
  final DateTime endAt;

  factory AvailibilityHour.fromMap(Map<String, dynamic> json) =>
      AvailibilityHour(
        startAt: DateTime.parse(json['startAt']),
        endAt: DateTime.parse(json['endAt']),
      );
}

/*
[
  {
    'displayName': 'Dalton Mckee',
    'address': '254 Lee Avenue, Leland, South Dakota, 2583',
    'description': 'Consectetur sint sunt in elit laboris id pariatur est mollit duis ipsum ea excepteur. Pariatur culpa tempor anim adipisicing qui do exercitation dolore. Elit consequat deserunt labore laborum. Do mollit nulla reprehenderit labore non incididunt commodo nulla Lorem occaecat nulla. Sunt quis esse irure ut officia commodo duis pariatur officia qui laboris.\r\n',
    'price': 32.8504,
    'type': 'football',
    'photoUrl': '',
    'availibility': [
      {
        'availableOn': '2022-02-27T08:12:03Z',
        'availableAt': [
          '2022-01-30T12:22:44Z',
          '2022-04-15T01:22:23Z'
        ]
      },
      {
        'availableOn': '2022-04-15T09:33:19Z',
        'availableAt': [
          '2022-03-14T09:50:25Z',
          '2022-02-21T03:45:11Z'
        ]
      },
      {
        'availableOn': '2022-03-21T05:08:59Z',
        'availableAt': [
          '2022-03-26T12:41:06Z',
          '2022-02-28T02:40:45Z'
        ]
      },
      {
        'availableOn': '2022-04-01T03:41:32Z',
        'availableAt': [
          '2022-01-07T07:59:56Z',
          '2022-03-25T05:28:46Z'
        ]
      },
      {
        'availableOn': '2022-01-12T06:08:40Z',
        'availableAt': [
          '2022-04-06T09:09:26Z',
          '2022-04-01T12:18:40Z'
        ]
      },
      {
        'availableOn': '2022-04-09T02:28:19Z',
        'availableAt': [
          '2022-04-05T04:13:34Z',
          '2022-03-15T02:18:20Z'
        ]
      }
    ]
  },
  {
    'displayName': 'Koch Contreras',
    'address': '484 Royce Place, Matthews, Utah, 7620',
    'description': 'Et amet nostrud irure veniam dolore. Consequat sunt voluptate laboris non elit aliquip consequat nisi consequat non minim. Ipsum sit ea do aute fugiat. Fugiat sint do laborum ea ipsum excepteur labore sunt cillum. Consectetur culpa excepteur occaecat ullamco quis nulla voluptate. Quis aliquip deserunt quis commodo. Amet amet quis ipsum aliqua laboris enim fugiat qui velit aliqua dolore adipisicing eiusmod.\r\n',
    'price': 22.9147,
    'type': 'football',
    'photoUrl': '',
    'availibility': [
      {
        'availableOn': '2022-01-16T05:08:37Z',
        'availableAt': [
          '2022-01-07T12:50:37Z',
          '2022-04-01T04:56:40Z'
        ]
      },
      {
        'availableOn': '2022-04-07T09:00:43Z',
        'availableAt': [
          '2022-03-02T12:07:42Z',
          '2022-02-07T09:48:23Z'
        ]
      },
      {
        'availableOn': '2022-01-11T10:35:58Z',
        'availableAt': [
          '2022-01-18T06:56:47Z',
          '2022-04-04T08:34:43Z'
        ]
      },
      {
        'availableOn': '2022-02-27T02:49:54Z',
        'availableAt': [
          '2022-02-27T11:20:17Z',
          '2022-03-05T04:18:19Z'
        ]
      },
      {
        'availableOn': '2022-02-10T05:09:21Z',
        'availableAt': [
          '2022-04-11T12:11:09Z',
          '2022-04-07T01:46:21Z'
        ]
      },
      {
        'availableOn': '2022-03-02T04:02:26Z',
        'availableAt': [
          '2022-02-02T12:19:39Z',
          '2022-02-21T11:50:45Z'
        ]
      }
    ]
  },
  {
    'displayName': 'Shepard Rosa',
    'address': '639 Battery Avenue, Gulf, Maine, 3007',
    'description': 'Nulla ullamco qui occaecat irure id voluptate aliqua. Sunt sint consectetur mollit laborum esse mollit minim nisi officia et. Proident et sunt fugiat mollit sunt mollit. Esse pariatur ullamco magna aliqua. Esse commodo consequat ad pariatur Lorem irure ipsum. Reprehenderit ad et ipsum esse aute commodo amet. Deserunt pariatur nostrud aliqua ipsum esse.\r\n',
    'price': 31.1307,
    'type': 'padel',
    'photoUrl': '',
    'availibility': [
      {
        'availableOn': '2022-03-20T07:06:36Z',
        'availableAt': [
          '2022-01-17T03:27:07Z',
          '2022-01-22T07:02:20Z'
        ]
      },
      {
        'availableOn': '2022-03-05T12:08:55Z',
        'availableAt': [
          '2022-04-15T07:35:24Z',
          '2022-03-09T10:38:05Z'
        ]
      },
      {
        'availableOn': '2022-04-03T01:43:56Z',
        'availableAt': [
          '2022-02-05T11:03:24Z',
          '2022-04-10T02:21:20Z'
        ]
      },
      {
        'availableOn': '2022-04-09T02:11:51Z',
        'availableAt': [
          '2022-01-14T11:40:28Z',
          '2022-03-11T01:32:25Z'
        ]
      },
      {
        'availableOn': '2022-02-25T05:35:40Z',
        'availableAt': [
          '2022-01-09T10:27:14Z',
          '2022-01-23T02:08:20Z'
        ]
      },
      {
        'availableOn': '2022-01-07T03:54:39Z',
        'availableAt': [
          '2022-02-16T03:33:11Z',
          '2022-03-19T07:00:02Z'
        ]
      }
    ]
  },
  {
    'displayName': 'Annmarie Gilmore',
    'address': '847 Hillel Place, Umapine, Nebraska, 2381',
    'description': 'Ea deserunt irure reprehenderit exercitation ullamco aliquip consequat excepteur duis. Ea pariatur fugiat adipisicing adipisicing dolor reprehenderit ipsum et ad culpa dolor ad. In est sint nulla esse incididunt magna aliqua.\r\n',
    'price': 3.9507,
    'type': 'football',
    'photoUrl': '',
    'availibility': [
      {
        'availableOn': '2022-01-28T11:44:23Z',
        'availableAt': [
          '2022-03-19T12:42:55Z',
          '2022-03-10T09:19:50Z'
        ]
      },
      {
        'availableOn': '2022-02-20T04:08:02Z',
        'availableAt': [
          '2022-02-18T11:40:30Z',
          '2022-03-19T07:00:42Z'
        ]
      },
      {
        'availableOn': '2022-01-14T04:20:18Z',
        'availableAt': [
          '2022-01-29T05:33:12Z',
          '2022-02-14T11:15:14Z'
        ]
      },
      {
        'availableOn': '2022-01-23T10:25:10Z',
        'availableAt': [
          '2022-04-12T09:04:31Z',
          '2022-01-15T01:52:25Z'
        ]
      },
      {
        'availableOn': '2022-03-20T11:54:18Z',
        'availableAt': [
          '2022-03-03T05:04:22Z',
          '2022-04-05T12:25:34Z'
        ]
      },
      {
        'availableOn': '2022-01-13T09:40:24Z',
        'availableAt': [
          '2022-01-17T07:16:46Z',
          '2022-04-08T04:52:30Z'
        ]
      }
    ]
  },
  {
    'displayName': 'Bush Mcknight',
    'address': '896 Commerce Street, Barronett, Palau, 9383',
    'description': 'Incididunt occaecat velit dolor occaecat. Minim laboris pariatur esse Lorem minim. Labore sunt esse laborum ad ullamco cillum. Ad commodo ex consequat tempor qui ipsum dolor ut sunt. Deserunt laboris duis in labore aliqua reprehenderit ex amet tempor minim. Duis mollit deserunt esse occaecat officia culpa reprehenderit laboris ut esse cillum reprehenderit qui nisi.\r\n',
    'price': 5.7503,
    'type': 'football',
    'photoUrl': '',
    'availibility': [
      {
        'availableOn': '2022-02-19T01:09:39Z',
        'availableAt': [
          '2022-03-09T02:55:05Z',
          '2022-01-16T01:32:30Z'
        ]
      },
      {
        'availableOn': '2022-01-20T04:30:27Z',
        'availableAt': [
          '2022-01-10T10:39:36Z',
          '2022-01-16T10:01:21Z'
        ]
      },
      {
        'availableOn': '2022-02-06T02:04:54Z',
        'availableAt': [
          '2022-03-12T07:38:59Z',
          '2022-02-14T12:57:25Z'
        ]
      },
      {
        'availableOn': '2022-04-06T12:02:04Z',
        'availableAt': [
          '2022-01-08T03:20:09Z',
          '2022-01-11T05:06:08Z'
        ]
      },
      {
        'availableOn': '2022-03-06T10:57:10Z',
        'availableAt': [
          '2022-03-14T12:37:59Z',
          '2022-01-23T06:30:09Z'
        ]
      },
      {
        'availableOn': '2022-03-02T02:10:22Z',
        'availableAt': [
          '2022-02-25T12:44:04Z',
          '2022-01-04T08:58:31Z'
        ]
      }
    ]
  },
  {
    'displayName': 'Fuentes Bradley',
    'address': '975 Stuart Street, Galesville, Michigan, 822',
    'description': 'Id commodo deserunt quis enim incididunt fugiat veniam duis fugiat elit amet nulla. Minim consectetur eiusmod deserunt exercitation Lorem occaecat elit est. Labore deserunt laboris commodo velit aliquip veniam quis occaecat mollit in aute in. Labore pariatur consectetur laborum esse consequat. Lorem ex do velit eiusmod pariatur velit veniam commodo consequat sunt dolore irure proident culpa.\r\n',
    'price': 21.8932,
    'type': 'padel',
    'photoUrl': '',
    'availibility': [
      {
        'availableOn': '2022-04-10T08:53:33Z',
        'availableAt': [
          '2022-04-11T08:10:47Z',
          '2022-01-28T08:07:27Z'
        ]
      },
      {
        'availableOn': '2022-03-08T04:03:44Z',
        'availableAt': [
          '2022-02-12T07:20:28Z',
          '2022-04-13T08:46:09Z'
        ]
      },
      {
        'availableOn': '2022-01-23T04:33:36Z',
        'availableAt': [
          '2022-02-17T02:40:21Z',
          '2022-04-06T06:52:00Z'
        ]
      },
      {
        'availableOn': '2022-01-29T06:22:03Z',
        'availableAt': [
          '2022-01-24T01:20:08Z',
          '2022-01-16T04:45:10Z'
        ]
      },
      {
        'availableOn': '2022-01-02T05:23:05Z',
        'availableAt': [
          '2022-03-01T05:53:35Z',
          '2022-03-13T03:31:39Z'
        ]
      },
      {
        'availableOn': '2022-02-05T12:00:13Z',
        'availableAt': [
          '2022-01-28T05:34:19Z',
          '2022-03-06T09:58:39Z'
        ]
      }
    ]
  },
  {
    'displayName': 'Lorna Stanley',
    'address': '264 Cooke Court, Vale, North Carolina, 7635',
    'description': 'Eiusmod nisi ullamco anim consectetur fugiat consequat et ut. Est et adipisicing aute ea ex commodo labore ex elit. Deserunt est officia id aute. Velit nisi voluptate do occaecat cillum ad Lorem consectetur est et duis et.\r\n',
    'price': 3.0192,
    'type': 'padel',
    'photoUrl': '',
    'availibility': [
      {
        'availableOn': '2022-02-20T08:41:17Z',
        'availableAt': [
          '2022-03-14T08:12:01Z',
          '2022-04-02T05:11:22Z'
        ]
      },
      {
        'availableOn': '2022-02-27T02:09:05Z',
        'availableAt': [
          '2022-04-13T02:24:31Z',
          '2022-02-07T10:23:30Z'
        ]
      },
      {
        'availableOn': '2022-02-01T11:05:09Z',
        'availableAt': [
          '2022-02-15T10:44:10Z',
          '2022-02-08T08:31:22Z'
        ]
      },
      {
        'availableOn': '2022-02-23T02:22:58Z',
        'availableAt': [
          '2022-04-12T08:08:22Z',
          '2022-03-30T12:18:29Z'
        ]
      },
      {
        'availableOn': '2022-01-18T04:01:03Z',
        'availableAt': [
          '2022-02-28T05:17:38Z',
          '2022-04-05T05:34:18Z'
        ]
      },
      {
        'availableOn': '2022-01-10T12:00:46Z',
        'availableAt': [
          '2022-02-20T04:10:02Z',
          '2022-02-21T12:19:02Z'
        ]
      }
    ]
  }
]
*/
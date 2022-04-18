import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models/firebase_models/notification_model.dart';
import 'package:padel/src/widgets/tiles.dart';
import 'package:padel/src/widgets/widget_models.dart';

class ScreenNotification extends StatefulWidget {
  const ScreenNotification({Key? key}) : super(key: key);

  @override
  State<ScreenNotification> createState() => _ScreenNotificationState();
}

class _ScreenNotificationState extends State<ScreenNotification> {
  List<NotificationModel> listNotification = [
    NotificationModel(
      uid: 'uid',
      displayname: 'displayname',
      imageurl: 'imageurl',
      content: 'content',
      time: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AppBarTitle(
          title: AppLocalizations.of(context)!.notifications,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showFutureAlertDialog(
                context: context,
                title: 'Delete',
                content:
                    'Are you sure you want to delete all your notifications',
                onYes: () async {
                  await Future.delayed(const Duration(seconds: 2));
                },
                onComplete: () {
                  showSnackBarMessage(
                    context: context,
                    fontSize: 14.sp,
                    hintMessage: 'you have deleted all your notifications',
                    icon: Icons.check_circle_outline_outlined,
                  );
                },
                onException: (e) {},
              );
              listNotification.clear();
              //TODO delete from firebase
            },
            icon: Icon(
              Icons.delete_outline,
              color: Theme.of(context).textTheme.headline1!.color,
              size: 26.sp,
            ),
          ),
        ],
      ),
      body: Column(
        children: const [NotificationTile(), NotificationTile()],
      ),
    );
  }
}

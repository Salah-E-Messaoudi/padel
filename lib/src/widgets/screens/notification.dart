import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/src/widgets/tiles.dart';
import 'package:padel/src/widgets/widget_models.dart';

class ScreenNotification extends StatelessWidget {
  const ScreenNotification({Key? key}) : super(key: key);

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
            onPressed: () {},
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

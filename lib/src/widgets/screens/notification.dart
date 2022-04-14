import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/src/widgets/tiles/notification_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScreenNotification extends StatelessWidget {
  const ScreenNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.notification,
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            color: Theme.of(context).textTheme.headline1!.color,
            fontWeight: FontWeight.w600,
          ),
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

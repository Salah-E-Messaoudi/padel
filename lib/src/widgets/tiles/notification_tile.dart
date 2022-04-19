import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key? key,
    required this.notification,
    required this.onTap,
  }) : super(key: key);

  final FBNotification notification;
  final Future<void> Function(FBNotification) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(notification),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28.sp,
              backgroundColor: Theme.of(context).textTheme.headline5!.color,
              backgroundImage: notification.photo,
            ),
            SizedBox(width: 10.w),
            SizedBox(
              width: 1.sw - 150.w,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: notification.displayName,
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: getNotificationText(context),
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Text(
              DateFormat('HH:mm').format(notification.createdAt) + '\n',
              style: GoogleFonts.poppins(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.headline3!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getNotificationText(BuildContext context) {
    switch (notification.key) {
      case 'friend_added':
        return AppLocalizations.of(context)!.friend_added;
      default:
        return notification.key;
    }
  }
}

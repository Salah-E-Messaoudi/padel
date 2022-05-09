import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/widgets/screens/my_friends.dart';
import 'package:padel/src/widgets/widget_models.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({
    Key? key,
    required this.user,
    required this.booking,
    required this.rebuildHomeScreen,
  }) : super(key: key);

  final UserData user;
  final BookingMax booking;
  final void Function() rebuildHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AppBarTitle(
          title: AppLocalizations.of(context)!.details,
        ),
        centerTitle: true,
        actions: [
          if (user.uid == booking.owner.uid)
            IconButton(
              onPressed: () async {
                showFutureAlertDialog(
                    context: context,
                    title: AppLocalizations.of(context)!.confirmation,
                    content: AppLocalizations.of(context)!.alert_cancel_booking,
                    onYes: () async {
                      await ListBookings.deleteFromDB(booking);
                    },
                    onComplete: () async {
                      rebuildHomeScreen();
                      Navigator.pop(context);
                      showSnackBarMessage(
                        context: context,
                        hintMessage: AppLocalizations.of(context)!
                            .booking_canceled_successfully,
                        icon: Icons.info_outline,
                      );
                    },
                    onException: (err) {
                      showSnackBarMessage(
                        context: context,
                        hintMessage:
                            AppLocalizations.of(context)!.unknown_error,
                        icon: Icons.info_outline,
                      );
                    });
              },
              icon: Icon(
                Icons.delete,
                size: 28.sp,
                color: Theme.of(context).textTheme.headline1!.color,
              ),
            )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Row(
              children: [
                Container(
                  height: 60.sp,
                  width: 60.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.sp),
                    color: Theme.of(context).textTheme.headline4!.color,
                    image: DecorationImage(
                      image: booking.owner.photo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                SizedBox(
                  width: 1.sw - 120.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.owner.displayName,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.owner,
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              booking.stadium.name,
              style: GoogleFonts.poppins(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headline1!.color,
              ),
            ),
            if (booking.stadium.address != null)
              Text(
                booking.stadium.address!,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.headline3!.color,
                ),
              ),
            SizedBox(height: 15.h),
            Text(
              booking.stadium.note,
              style: GoogleFonts.poppins(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.headline2!.color,
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 30.sp,
                      color: Theme.of(context).textTheme.headline4!.color,
                    ),
                    SizedBox(width: 5.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.time,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.headline3!.color,
                          ),
                        ),
                        Text(
                          DateFormat('HH:mm').format(booking.details.startAt) +
                              ' - ' +
                              DateFormat('HH:mm').format(booking.details.endAt),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 35.w),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 30.sp,
                      color: Theme.of(context).textTheme.headline4!.color,
                    ),
                    SizedBox(width: 5.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.date,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.headline3!.color,
                          ),
                        ),
                        Text(
                          DateFormat('EEE dd MMM')
                              .format(booking.details.startAt),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 35.w),
                Row(
                  children: [
                    Icon(
                      Icons.sports_soccer_rounded,
                      size: 30.sp,
                      color: Theme.of(context).textTheme.headline4!.color,
                    ),
                    SizedBox(width: 5.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.event,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.headline3!.color,
                          ),
                        ),
                        Text(
                          booking.stadium.type == 'padel'
                              ? AppLocalizations.of(context)!.padel
                              : AppLocalizations.of(context)!.football,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.team_members,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                  TextSpan(
                    text: '(' +
                        booking.teamCount.toString() +
                        '/' +
                        (booking.stadium.type == 'padel' ? '4' : '11') +
                        ')',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.headline3!.color,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                SizedBox(
                  height: 45.h,
                  width: 210.w,
                  child: ListView.builder(
                      itemCount: min(booking.teamCount, 4),
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              height: 44.sp,
                              width: 44.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.sp),
                                color: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .color,
                                image: DecorationImage(
                                  image: booking.details.listphotoURL[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                          ],
                        );
                      }),
                ),
                SizedBox(width: 10.w),
                if (booking.teamCount > 4)
                  Row(
                    children: [
                      Container(
                        height: 44.sp,
                        width: 44.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.sp),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.25),
                        ),
                        child: Center(
                          child: Text(
                            '+${booking.teamCount - 4}',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        AppLocalizations.of(context)!.members,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            if (booking.isOwner(user.uid)) SizedBox(height: 20.h),
            if (booking.isOwner(user.uid))
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyFriends(user: user, booking: booking),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 44.sp,
                      width: 44.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.sp),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        size: 28.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      AppLocalizations.of(context)!.add_new_member,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 25.h),
            Text(
              AppLocalizations.of(context)!.look_stadium,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.headline4!.color,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.sp),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: booking.stadium.photo == null
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: Icon(
                          Icons.photo_size_select_actual_rounded,
                          size: 34.sp,
                          color: Colors.white,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12.sp),
                        child: Image(
                          image: booking.stadium.photo!,
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

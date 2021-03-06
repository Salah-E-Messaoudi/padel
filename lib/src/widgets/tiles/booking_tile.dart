import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/widgets/screens.dart';

class BookingTile extends StatelessWidget {
  const BookingTile({
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
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingDetails(
            user: user,
            booking: booking,
            rebuildHomeScreen: rebuildHomeScreen,
          ),
        ),
      ),
      child: Container(
        width: 1.sw - 30.w,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          border: Border.all(
            width: 1.5,
            color: Theme.of(context).textTheme.headline5!.color!,
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 8.w),
            Container(
              height: 90.sp,
              width: 90.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.sp),
                color: Theme.of(context).textTheme.headline5!.color,
                image: booking.stadium.avatar == null
                    ? null
                    : DecorationImage(
                        image: booking.stadium.avatar!,
                        fit: BoxFit.cover,
                      ),
              ),
              child: booking.stadium.avatar == null
                  ? Icon(
                      Icons.photo_size_select_actual_rounded,
                      size: 24.sp,
                      color: Colors.white,
                    )
                  : null,
            ),
            SizedBox(width: 10.w),
            SizedBox(
              height: 90.sp,
              width: 1.sw - 150.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    booking.stadium.name,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
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
                        height: 1,
                        color: Theme.of(context).textTheme.headline3!.color,
                      ),
                    ),
                  SizedBox(height: 4.h),
                  Text(
                    booking.stadium.type == 'PADEL'
                        ? AppLocalizations.of(context)!
                            .type_match(AppLocalizations.of(context)!.padel)
                        : AppLocalizations.of(context)!
                            .type_match(AppLocalizations.of(context)!.football),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline6!.color,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!booking.canceled)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.team,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .color,
                              ),
                            ),
                            Text(
                              booking.countText,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                              ),
                            ),
                          ],
                        ),
                      if (!booking.canceled)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.date_time,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .color,
                              ),
                            ),
                            Text(
                              DateFormat('EEE dd MMM ??? HH:mm')
                                      .format(booking.details.startAt) +
                                  ' - ' +
                                  DateFormat('HH:mm')
                                      .format(booking.details.endAt),
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                              ),
                            ),
                          ],
                        ),
                      if (booking.canceled)
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: const Color(0xFFC21717)),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.canceled,
                              style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 20.sp,
                        width: 20.sp,
                        child: user.uid == booking.owner.uid
                            ? Icon(
                                Icons.badge_outlined,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .color,
                                size: 20.sp,
                              )
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

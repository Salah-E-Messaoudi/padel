import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/widgets/screens.dart';

class BookingTile extends StatelessWidget {
  const BookingTile({Key? key, required this.user, required this.booking})
      : super(key: key);

  final UserData user;
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingDetails(
            user: user,
            booking: booking,
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
                image: DecorationImage(
                  image: booking.stadium.photo!,
                  fit: BoxFit.cover,
                ),
              ),
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
                    booking.stadium.displayName,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                  Text(
                    booking.stadium.address,
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
                    booking.stadium.type == 'padel'
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.team,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).textTheme.headline3!.color,
                            ),
                          ),
                          Text(
                            booking.listphotoURL.length.toString() +
                                '/' +
                                (booking.stadium.type == 'padel' ? '4' : '11'),
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.date_time,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).textTheme.headline3!.color,
                            ),
                          ),
                          Text(
                            DateFormat('EEE dd MMM • HH:mm')
                                    .format(booking.startAt) +
                                ' - ' +
                                DateFormat('HH:mm').format(booking.endAt),
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                            ),
                          ),
                        ],
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

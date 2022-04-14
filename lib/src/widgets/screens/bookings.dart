import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/src/widgets/tiles/booking_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 18.h),
        Text(
          AppLocalizations.of(context)!.bookings_title,
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headline1!.color,
          ),
        ),
        Text(
          AppLocalizations.of(context)!.bookings_subtitle,
          style: GoogleFonts.poppins(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.headline3!.color,
          ),
        ),
        SizedBox(height: 25.h),
        const BookingTile()
      ],
    );
  }
}

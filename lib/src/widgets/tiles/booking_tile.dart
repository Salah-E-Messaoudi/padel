import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingTile extends StatelessWidget {
  const BookingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 30.w,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          border: Border.all(
              width: 1.5,
              color: Theme.of(context).textTheme.headline5!.color!)),
      child: Row(
        children: [
          SizedBox(width: 8.w),
          Container(
            height: 90.sp,
            width: 90.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.sp),
              color: Theme.of(context).textTheme.headline5!.color,
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
                  'Stadium Name N1',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.headline1!.color,
                  ),
                ),
                Text(
                  'Jassem Mohammad Al-Kharafi Rd, Kuwait',
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
                  'Padel Match',
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
                          'Team',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.headline3!.color,
                          ),
                        ),
                        Text(
                          '4 / 4 Joined',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 30.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date Time',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.headline3!.color,
                          ),
                        ),
                        Text(
                          '8 Apr • 16:00 - 17:00',
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
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AvailableStadiumsTile extends StatelessWidget {
  const AvailableStadiumsTile({Key? key}) : super(key: key);

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
                info(context, 'Saturday - Thursday'),
                info(context, 'Jassem Mohammad Al-Kharafi Rd, Kuwait'),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).textTheme.headline5!.color,
                      ),
                      child: Text(
                        'Padel',
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                    ),
                    const Spacer(),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '19.50',
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF009A61),
                            ),
                          ),
                          TextSpan(
                            text: ' hour',
                            style: GoogleFonts.poppins(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF009A61),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Row info(BuildContext context, String info) {
    return Row(
      children: [
        SizedBox(width: 5.w),
        Text(
          '• ',
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.headline3!.color,
          ),
        ),
        SizedBox(
          width: 1.sw - 162.w,
          child: Text(
            info,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.headline3!.color,
            ),
          ),
        ),
      ],
    );
  }
}

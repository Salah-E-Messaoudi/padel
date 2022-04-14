import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PendingInvitationTile extends StatelessWidget {
  const PendingInvitationTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Theme.of(context).textTheme.headline5!.color!,
        ),
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22.sp,
                      backgroundColor:
                          Theme.of(context).textTheme.headline5!.color,
                    ),
                    SizedBox(width: 10.w),
                    SizedBox(
                      width: 1.sw - 200.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Invite From',
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              height: 1,
                              color:
                                  Theme.of(context).textTheme.headline3!.color,
                            ),
                          ),
                          Text(
                            'Khalid Ghazi',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      children: [
                        Text(
                          'Event',
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.headline3!.color,
                          ),
                        ),
                        Text(
                          'Padel Match',
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline6!.color,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10.h),
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
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                          '16:00 - 17:00',
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
                          AppLocalizations.of(context)!.date,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.headline3!.color,
                          ),
                        ),
                        Text(
                          '8 Apr',
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
                          AppLocalizations.of(context)!.team,
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
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Divider(
            thickness: 1.5,
            color: Theme.of(context).textTheme.headline5!.color,
            height: 1,
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: (1.sw - 50) / 2,
                    height: 40.h,
                    child: Center(
                      child: Text(
                        'Accept',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF278E67),
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Theme.of(context).textTheme.headline5!.color,
                  width: 1.5,
                  thickness: 1.5,
                ),
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: (1.sw - 50) / 2,
                    height: 40.h,
                    child: Center(
                      child: Text(
                        'Reject',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFC1111),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

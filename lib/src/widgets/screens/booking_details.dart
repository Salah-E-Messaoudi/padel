import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/src/models.dart/team_members.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TeamMember> teamMembers = [
      TeamMember(imageUrl: 'imageUrl', uid: 'uid'),
      TeamMember(imageUrl: 'imageUrl', uid: 'uid'),
      TeamMember(imageUrl: 'imageUrl', uid: 'uid'),
      TeamMember(imageUrl: 'imageUrl', uid: 'uid'),
      TeamMember(imageUrl: 'imageUrl', uid: 'uid'),
      TeamMember(imageUrl: 'imageUrl', uid: 'uid'),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.details,
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            color: Theme.of(context).textTheme.headline1!.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
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
                  ),
                ),
                SizedBox(width: 15.w),
                SizedBox(
                  width: 1.sw - 120.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Salah Eddine Messaoudi',
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
              'International Outdoor Tennis Stadium',
              style: GoogleFonts.poppins(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headline1!.color,
              ),
            ),
            Text(
              'Jassem Mohammad Al-Kharafi Rd, Kuwait',
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.headline3!.color,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              'As absolute is by amounted repeated entirely ye returned. These ready timed enjoy might sir yet one since. Years drift never if could forty being no.',
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
                          'Football',
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
                    text: ' (10/11)',
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
                      itemCount:
                          teamMembers.length > 4 ? 4 : teamMembers.length,
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
                              ),
                            ),
                            SizedBox(width: 10.w),
                          ],
                        );
                      }),
                ),
                SizedBox(width: 10.w),
                if (teamMembers.length > 4)
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
                            '+${teamMembers.length - 4}',
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
            SizedBox(height: 20.h),
            Row(
              children: [
                Container(
                  height: 44.sp,
                  width: 44.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.sp),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_rounded,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 28.sp,
                    ),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.sp),
                  child: const Image(
                    image: AssetImage('assets/images/example.jpg'),
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

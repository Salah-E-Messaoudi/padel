import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: Colors.amber,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28.sp,
                backgroundColor: Theme.of(context).textTheme.headline5!.color,
              ),
              SizedBox(width: 10.w),
              SizedBox(
                width: 1.sw - 150.w,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Khalid Ghazi',
                        style: GoogleFonts.poppins(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' has invited you to join him into a Padel match on 8 Apr',
                        style: GoogleFonts.poppins(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '09:20\n',
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.headline3!.color,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Divider(
            thickness: 1.5,
            color: Theme.of(context).textTheme.headline5!.color!,
          ),
        )
      ],
    );
  }
  // String notificationMsg(BuildContext context ,String event, String result){
  //   switch (event) {
  //     case 'padel':
  //       switch (result) {
  //         case 'accept':
  //           return AppLocalizations.of(context)!.notification
  //           break;
  //         default:
  //       }
  //       break;
  //     case 'football':
  //     default:
  //   }
  // }
}

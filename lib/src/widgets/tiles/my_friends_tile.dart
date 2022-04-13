import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFriendsTile extends StatelessWidget {
  const MyFriendsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28.sp,
                backgroundColor: Theme.of(context).textTheme.headline5!.color,
              ),
              SizedBox(width: 10.w),
              SizedBox(
                width: 1.sw - 110.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Khalid Ghazi',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                    ),
                    Text(
                      '+965 2997 5820',
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.headline3!.color,
                      ),
                    ),
                  ],
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
}

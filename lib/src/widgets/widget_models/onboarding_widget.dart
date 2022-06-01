import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String imagePath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image(
            image: AssetImage(imagePath),
            width: 0.75.sw,
          ),
        ),
        SizedBox(height: 60.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sp),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: Theme.of(context).textTheme.headline1!.color,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
        ),
        SizedBox(height: 10.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sp),
          child: Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: Theme.of(context).textTheme.headline2!.color,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/src/widgets/tiles/available_staduims_tile.dart';

class Stadiums extends StatefulWidget {
  const Stadiums({Key? key}) : super(key: key);

  @override
  State<Stadiums> createState() => _StadiumsState();
}

class _StadiumsState extends State<Stadiums> {
  int currentTap = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.h),
        Text(
          'Hi, Salah Eddine',
          style: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headline1!.color,
          ),
        ),
        Text(
          "Let's Book A Stadium And Plan Our Game",
          style: GoogleFonts.poppins(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.headline3!.color,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'You want to book',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.headline1!.color,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            menuCard(context, 0, 'both', 'All'),
            menuCard(context, 1, 'padel', 'Padel'),
            menuCard(context, 2, 'football', 'FootBall'),
          ],
        ),
        SizedBox(height: 15.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: const Image(
            image: AssetImage('assets/images/banner.jpg'),
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'Available Stadiums',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.headline1!.color,
          ),
        ),
        SizedBox(height: 10.h),
        const AvailableStadiumsTile(),
      ],
    );
  }

  Widget menuCard(BuildContext context, int index, String icon, String label) {
    return InkWell(
      onTap: () {
        setState(() => currentTap = index);
      },
      child: Container(
        width: (1.sw - 50) / 3,
        height: 80.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: currentTap == index
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/$icon.svg',
              color: currentTap == index
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              width: ((1.sw - 50) / 3) / 4,
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                height: 1,
                fontWeight: FontWeight.w600,
                color: currentTap == index
                    ? Colors.white
                    : Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

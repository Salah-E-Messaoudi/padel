import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/src/widgets/screens.dart';

class AvailableStadiumsTile extends StatelessWidget {
  const AvailableStadiumsTile({
    Key? key,
    required this.user,
    required this.stadium,
    required this.changeTab,
  }) : super(key: key);

  final UserData user;
  final Stadium stadium;
  final void Function(int) changeTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StadiumDetails(
            user: user,
            stadium: stadium,
            changeTab: changeTab,
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
                image: stadium.photo == null
                    ? null
                    : DecorationImage(
                        image: stadium.photo!,
                        fit: BoxFit.cover,
                      ),
              ),
              child: stadium.photo == null
                  ? Icon(
                      Icons.photo_size_select_actual_rounded,
                      size: 24.sp,
                      color: Colors.white,
                    )
                  : null,
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
                    stadium.name,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                  const InfoWidget(info: 'Saturday - Thursday'),
                  if (stadium.address != null)
                    InfoWidget(info: stadium.address!),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).textTheme.headline5!.color,
                        ),
                        child: Text(
                          stadium.type == 'padel'
                              ? AppLocalizations.of(context)!.padel
                              : AppLocalizations.of(context)!.football,
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        AppLocalizations.of(context)!.price_kdw(
                          NumberFormat('#0.00').format(stadium.price),
                        ),
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF009A61),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key? key,
    required this.info,
  }) : super(key: key);

  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            '• ',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.headline3!.color,
            ),
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

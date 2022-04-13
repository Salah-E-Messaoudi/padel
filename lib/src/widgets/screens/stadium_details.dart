import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:padel/src/models.dart/available_time.dart';
import 'package:padel/src/widgets/widget_modules.dart';

class StadiumDetails extends StatefulWidget {
  const StadiumDetails({Key? key}) : super(key: key);

  @override
  State<StadiumDetails> createState() => _StadiumDetailsState();
}

class _StadiumDetailsState extends State<StadiumDetails> {
  int? currentIndex;
  DateTime? customDate;
  List<AvailableTime> listTime = [
    AvailableTime(available: true, time: '10:00 - 11:00'),
    AvailableTime(available: true, time: '11:00 - 12:00'),
    AvailableTime(available: true, time: '12:00 - 13:00'),
    AvailableTime(available: true, time: '13:00 - 14:00'),
    AvailableTime(available: false, time: '14:00 - 15:00'),
    AvailableTime(available: false, time: '15:00 - 16:00'),
    AvailableTime(available: true, time: '16:00 - 17:00'),
    AvailableTime(available: false, time: '17:00 - 18:00'),
    AvailableTime(available: true, time: '18:00 - 19:00'),
  ];

  String? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).viewPadding.top),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14.sp),
                  bottomRight: Radius.circular(14.sp),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.sp),
                    bottomRight: Radius.circular(16.sp),
                  ),
                  child: const Image(
                    image: AssetImage('assets/images/example.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.w),
                    child: Divider(
                      thickness: 2,
                      color: Theme.of(context).textTheme.headline5!.color,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 30.w),
                      const Spacer(),
                      Text(
                        'This Week',
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 30.w,
                        height: 30.h,
                        child: IconButton(
                          onPressed: () {
                            DatePicker.showDatePicker(
                              context,
                              theme: DatePickerTheme(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                cancelStyle: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .color,
                                ),
                                doneStyle: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                ),
                                itemStyle: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .color,
                                ),
                              ),
                              showTitleActions: true,
                              minTime: DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day),
                              maxTime: DateTime(2022, 12, 30),
                              onConfirm: (date) {
                                setState(() {
                                  customDate = date;
                                  currentIndex = null;
                                });
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en,
                            );
                          },
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.calendar_month_outlined,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      date(context, 0),
                      date(context, 1),
                      date(context, 2),
                      date(context, 3),
                      date(context, 4),
                      date(context, 5),
                      date(context, 6),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  if (customDate != null)
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Selected Date : ',
                              style: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .color,
                              ),
                            ),
                            TextSpan(
                              text: DateFormat(' EEE dd MMM')
                                  .format(customDate!)
                                  .toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 15.h),
                  Center(
                    child: Text(
                      'Select Time',
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10.sp,
                      runSpacing: 10.sp,
                      direction: Axis.horizontal,
                      children: listTime
                          .map((i) => selectTime(context, i.available, i.time))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    children: [
                      Text(
                        '18.50 KDW',
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                      const Spacer(),
                      CustomIconTextButton(
                        label: 'BOOK NOW',
                        onPressed: () {},
                        fontColor: Colors.white,
                        fontSize: 15.sp,
                        // fixedSize: Size(0.8.sw, 45.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      // child: Row(
      //   children: [
      //     Text(
      //       '18.50 KDW',
      //       style: GoogleFonts.poppins(
      //         fontSize: 15.sp,
      //         fontWeight: FontWeight.bold,
      //         color: Theme.of(context).textTheme.headline1!.color,
      //       ),
      //     ),
      //     const Spacer(),
      //     CustomIconTextButton(
      //       label: 'BOOK NOW',
      //       onPressed: () {},
      //       fontColor: Colors.white,
      //       fontSize: 15.sp,
      //       // fixedSize: Size(0.8.sw, 45.sp),
      //     ),
      //   ],
      // ),
      // ),
    );
  }

  InkWell selectTime(BuildContext context, bool available, String time) {
    return InkWell(
      onTap: () {
        if (available) {
          setState(() => selectedTime = time);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: available
                ? selectedTime == time
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.headline4!.color!
                : Theme.of(context).textTheme.headline5!.color!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
          color: selectedTime == time
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Text(
          time,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: available
                ? selectedTime == time
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).textTheme.headline4!.color!
                : Theme.of(context).textTheme.headline5!.color!,
          ),
        ),
      ),
    );
  }

  Padding date(BuildContext context, int index) {
    int day = DateTime.now().day + index;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
            customDate = null;
          });
        },
        child: Column(
          children: [
            Text(
              DateFormat('EEE').format(
                DateTime(DateTime.now().year, DateTime.now().month, day),
              ),
              //
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: currentIndex != null
                    ? currentIndex == index
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.headline3!.color
                    : Theme.of(context).textTheme.headline3!.color,
              ),
            ),
            Text(
              (DateTime.now().day + index).toString(),
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: currentIndex != null
                    ? currentIndex == index
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.headline1!.color
                    : Theme.of(context).textTheme.headline1!.color,
              ),
            ),
            if (currentIndex != null && currentIndex == index)
              SizedBox(
                width: 20.w,
                child: Divider(
                  height: 5,
                  thickness: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/widgets/widget_models.dart';

class StadiumDetails extends StatefulWidget {
  const StadiumDetails({
    Key? key,
    required this.stadiummax,
  }) : super(key: key);

  final StadiumMax stadiummax;

  @override
  State<StadiumDetails> createState() => _StadiumDetailsState();
}

class _StadiumDetailsState extends State<StadiumDetails> {
  DateTime? customDate;
  DateTime? selectedDate;
  String? selectedTime;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: MediaQuery.of(context).viewPadding.top),
            Stack(
              children: [
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
                        offset: const Offset(0, 2),
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
                      child: Image(
                        image: widget.stadiummax.stadium.photo!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).viewPadding.top,
                  left: 10.w,
                  child: InkWell(
                    onTap: (() => Navigator.pop(context)),
                    child: Container(
                      width: 36.sp,
                      height: 36.sp,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.7),
                        borderRadius: BorderRadius.circular(14.sp),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20.sp,
                          color: Theme.of(context).textTheme.headline2!.color,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.stadiummax.stadium.displayName,
                    style: GoogleFonts.poppins(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                  Text(
                    widget.stadiummax.stadium.address,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.headline3!.color,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    widget.stadiummax.stadium.description,
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
                        AppLocalizations.of(context)!.this_week,
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
                              minTime: DateTime.now(),
                              maxTime:
                                  DateTime.now().add(const Duration(days: 90)),
                              onConfirm: (date) {
                                setState(() {
                                  customDate = date;
                                  selectedDate = date;
                                });
                              },
                              currentTime: selectedDate ?? customDate,
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
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 60.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        7,
                        (index) => SelectDate(
                          customDate: customDate,
                          index: index,
                          selectedDate: selectedDate,
                          onTap: (date) => setState(
                            () {
                              selectedDate = date;
                              customDate = null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.sp,
                    child: customDate != null
                        ? Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .selected_date,
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
                          )
                        : null,
                  ),
                  SizedBox(height: 15.h),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10.sp,
                      runSpacing: 10.sp,
                      direction: Axis.horizontal,
                      children: listTime
                          .map((i) => SelectTime(
                              time: i.time,
                              selectedTime: selectedTime,
                              available: i.available,
                              onTap: () =>
                                  setState(() => selectedTime = i.time)))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.price_kdw(NumberFormat('#0.00')
                    .format(widget.stadiummax.stadium.price)),
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
              const Spacer(),
              CustomIconTextButton(
                label: AppLocalizations.of(context)!.book_now,
                onPressed: () {
                  if (isValide) {
                    showFutureAlertDialog(
                        context: context,
                        title: 'Book A Stadium',
                        content:
                            'Are you sure you want to book this stadium with selected date and time',
                        onYes: () async {
                          //TODO book
                          await Future.delayed(const Duration(seconds: 1));
                        },
                        onComplete: () {
                          Navigator.pop(context);
                          showSnackBarMessage(
                            context: context,
                            fontSize: 14.sp,
                            hintMessage:
                                'You have successfuly booked this stadium',
                            icon: Icons.check_circle_outline_outlined,
                          );
                        });
                    //TODO book
                  } else {
                    showSnackBarMessage(
                      context: context,
                      hintMessage: 'Please Select Date And Time',
                      icon: Icons.info_outline_rounded,
                    );
                  }
                },
                fontColor: Colors.white,
                fontSize: 15.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get isValide =>
      (customDate != null || selectedDate != null) && selectedTime != null;
}

class SelectTime extends StatelessWidget {
  const SelectTime({
    Key? key,
    required this.time,
    required this.selectedTime,
    required this.available,
    required this.onTap,
  }) : super(key: key);

  final String time;
  final String? selectedTime;
  final bool available;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: available ? onTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: available
                ? selectedTime == time
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.headline3!.color!
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
                    : Theme.of(context).textTheme.headline3!.color!
                : Theme.of(context).textTheme.headline5!.color!,
          ),
        ),
      ),
    );
  }
}

class SelectDate extends StatefulWidget {
  const SelectDate({
    Key? key,
    required this.customDate,
    required this.index,
    required this.selectedDate,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final DateTime? customDate;
  final DateTime? selectedDate;
  final void Function(DateTime) onTap;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  late DateTime date;

  @override
  void initState() {
    super.initState();
    date = DateTime.now().add(Duration(days: widget.index));
  }

  bool get isSelected =>
      widget.selectedDate != null &&
      widget.selectedDate!.year == date.year &&
      widget.selectedDate!.month == date.month &&
      widget.selectedDate!.day == date.day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () => widget.onTap(date),
        child: Column(
          children: [
            Text(
              DateFormat('EEE').format(date),
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.headline3!.color,
              ),
            ),
            Text(
              (DateTime.now().day + widget.index).toString(),
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.headline3!.color,
              ),
            ),
            if (isSelected)
              SizedBox(
                width: 20.w,
                child: Divider(
                  height: 5.sp,
                  thickness: 2.sp,
                  color: Theme.of(context).primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

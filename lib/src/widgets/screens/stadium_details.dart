import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';
import 'package:padel/src/widgets/tiles.dart';
import 'package:padel/src/widgets/widget_models.dart';

class StadiumDetails extends StatefulWidget {
  const StadiumDetails({
    Key? key,
    required this.user,
    required this.stadium,
    required this.changeTab,
  }) : super(key: key);

  final UserData? user;
  final Stadium stadium;
  final void Function(int) changeTab;

  @override
  State<StadiumDetails> createState() => _StadiumDetailsState();
}

class _StadiumDetailsState extends State<StadiumDetails> {
  DateTime? customDate;
  DateTime? selectedDate = DateTime.now();
  AvailableTime? selectedTime;
  List<AvailibilitySlot>? availableSlots;

  List<AvailableTime> listTime = List.generate(
    15,
    (index) => AvailableTime.fromTime(
      Random().nextInt(2) == 0,
      index + 8,
    ),
  ).toList();

  Future<void> getAvailableSlots() async {
    if (widget.stadium.images == null && widget.stadium.avatar != null) {
      await widget.stadium.updateImage();
    }
    if (availableSlots != null || selectedDate == null) {
      return;
    }
    String date =
        '${NumberFormat('0000').format(selectedDate!.year)}-${NumberFormat('00').format(selectedDate!.month)}-${NumberFormat('00').format(selectedDate!.day)}';
    availableSlots = await ApiCalls.getAvailableSlots(
      widget.stadium.id,
      date,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAvailableSlots(),
        builder: (context, snapshot) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              color: Colors.grey.shade200,
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: AspectRatio(
                          aspectRatio: 16 / 10,
                          child: widget.stadium.avatar == null
                              ? Icon(
                                  Icons.photo_size_select_actual_rounded,
                                  size: 34.sp,
                                  color: Colors.white,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16.sp),
                                    bottomRight: Radius.circular(16.sp),
                                  ),
                                  child: widget.stadium.images != null &&
                                          widget.stadium.images!.isNotEmpty
                                      ? ImageSlideshow(
                                          indicatorColor:
                                              Theme.of(context).primaryColor,
                                          // isLoop: true,
                                          children: widget.stadium.images!
                                              .map((image) => Image(
                                                    image: image,
                                                    fit: BoxFit.fill,
                                                  ))
                                              .toList(),
                                        )
                                      : Image(
                                          image: widget.stadium.avatar!,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).viewPadding.top + 10.h,
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
                                color: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .color,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (widget.stadium.images == null &&
                          widget.stadium.avatar != null)
                        Positioned.fill(
                          top: MediaQuery.of(context).viewPadding.top + 40.h,
                          child: const LoadingTile(),
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
                          widget.stadium.name,
                          style: GoogleFonts.poppins(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                        if (widget.stadium.address != null)
                          Text(
                            widget.stadium.address!,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline3!.color,
                            ),
                          ),
                        SizedBox(height: 15.h),
                        if (widget.stadium.note != null)
                          Text(
                            widget.stadium.note!,
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline2!.color,
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
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
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
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
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
                                    maxTime: DateTime.now()
                                        .add(const Duration(days: 90)),
                                    onConfirm: onPickDate,
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
                                onTap: onPickDate,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            height: 24.sp,
                            child: customDate != null &&
                                    customDate!
                                            .difference(DateTime.now())
                                            .inDays >
                                        5
                                ? RichText(
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
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Text(
                                    AppLocalizations.of(context)!
                                        .pick_your_session,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .color,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        availableSlots == null && selectedDate != null
                            ? const LoadingTile()
                            : Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 10.sp,
                                  runSpacing: 10.sp,
                                  direction: Axis.horizontal,
                                  children: listTime
                                      .map(
                                        (i) => SelectTime(
                                          time: i.time,
                                          selected: selectedTime == i,
                                          available: (availableSlots ?? []).any(
                                              (element) =>
                                                  element.slot == i.time),
                                          onTap: () {
                                            setState(() => selectedTime = i);
                                          },
                                        ),
                                      )
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
                      AppLocalizations.of(context)!.price_kdw(
                          NumberFormat('#0.00').format(widget.stadium.price)),
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                    ),
                    const Spacer(),
                    if (widget.user != null)
                      CustomIconTextButton(
                        label: AppLocalizations.of(context)!.book_now,
                        onPressed: () {
                          if (isValide) {
                            showFutureAlertDialog(
                                context: context,
                                title: AppLocalizations.of(context)!
                                    .alert_booking_confirmation_title,
                                content: AppLocalizations.of(context)!
                                    .alert_booking_confirmation_subtitle,
                                onYes: () async {
                                  Map<String, dynamic> data = {
                                    'stadium': widget.stadium.toMap(),
                                    'owner': widget.user!.toUserMin(),
                                    'list_added': [widget.user!.uid],
                                    'list_invited': [],
                                    'list_photoURL': [widget.user!.photoUrl],
                                    'createdAt': FieldValue.serverTimestamp(),
                                    'startAt':
                                        selectedTime!.getStartAt(selectedDate!),
                                    'endAt':
                                        selectedTime!.getEndAt(selectedDate!),
                                  };
                                  await BookingsService.book(
                                    userId: widget.user!.odooId!,
                                    stadiumId: widget.stadium.id,
                                    date:
                                        '${selectedDate!.year}-${NumberFormat('00').format(selectedDate!.month)}-${NumberFormat('00').format(selectedDate!.day)}',
                                    session: selectedTime!.time
                                        .replaceAll('-', 'to'),
                                    data: data,
                                  );
                                },
                                onComplete: () {
                                  Navigator.pop(context);
                                  showSnackBarMessage(
                                    context: context,
                                    fontSize: 14.sp,
                                    hintMessage: AppLocalizations.of(context)!
                                        .session_booked_successfully,
                                    icon: Icons.check_circle_outline_outlined,
                                  );
                                  widget.changeTab(1);
                                },
                                onException: (e) {
                                  if (e is FirebaseException) {
                                    showSnackBarMessage(
                                      context: context,
                                      hintMessage: AppLocalizations.of(context)!
                                          .session_already_taken,
                                      icon: Icons.info_outline,
                                    );
                                  } else if (e is APIException) {
                                    showSnackBarMessage(
                                      context: context,
                                      hintMessage: AppLocalizations.of(context)!
                                          .session_already_taken,
                                      icon: Icons.info_outline,
                                    );
                                  } else {
                                    showSnackBarMessage(
                                      context: context,
                                      hintMessage: AppLocalizations.of(context)!
                                          .unknown_error,
                                      icon: Icons.info_outline,
                                    );
                                  }
                                });
                          } else {
                            showSnackBarMessage(
                              context: context,
                              hintMessage: AppLocalizations.of(context)!
                                  .complete_booking,
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
        });
  }

  void onPickDate(date) {
    setState(() {
      customDate = date;
      selectedDate = date;
      selectedTime = null;
      availableSlots = null;
    });
  }

  bool get isValide =>
      (customDate != null || selectedDate != null) && selectedTime != null;
}

class SelectTime extends StatelessWidget {
  const SelectTime({
    Key? key,
    required this.time,
    required this.selected,
    required this.available,
    required this.onTap,
  }) : super(key: key);

  final String time;
  final bool selected;
  final bool available;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: available ? onTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        alignment: Alignment.center,
        width: 110.sp,
        decoration: BoxDecoration(
          border: Border.all(
            color: available
                ? (selected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.headline3!.color!)
                : Theme.of(context).textTheme.headline5!.color!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
          color: selected
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Text(
          time,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: available
                ? (selected
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).textTheme.headline3!.color!)
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

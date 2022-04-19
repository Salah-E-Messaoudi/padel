import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/widgets/tiles.dart';
import 'package:padel/src/widgets/widget_models.dart';

class Bookings extends StatefulWidget {
  const Bookings({
    Key? key,
    required this.user,
    required this.controller,
    required this.currentIndex,
  }) : super(key: key);

  final UserData user;
  final ScrollController controller;
  final int currentIndex;

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.currentIndex == 1 ? ListBookings.get() : null,
      builder: (context, _) {
        return CustomScrollView(
          controller: widget.controller,
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                AppLocalizations.of(context)!.bookings_title,
                style: GoogleFonts.poppins(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                AppLocalizations.of(context)!.bookings_subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.headline3!.color,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 15.h),
                child: ListBookings.isNull
                    ? const LoadingTile()
                    : ListBookings.isEmpty
                        ? EmptyListView(
                            text: AppLocalizations.of(context)!.empty_bookings,
                            topPadding: 300.h,
                          )
                        : const SizedBox.shrink(),
              ),
            ),
            if (ListBookings.isNotNull && ListBookings.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => BookingTile(
                    user: widget.user,
                    booking: ListBookings.list[index],
                  ),
                  childCount: ListBookings.list.length,
                ),
              ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: max(0, 6 - ListBookings.list.length) * 100.h,
              ),
            ),
          ],
        );
      },
    );
  }
}

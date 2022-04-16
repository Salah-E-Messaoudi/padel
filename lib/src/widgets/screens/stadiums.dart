import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/widgets/tiles.dart';

class Stadiums extends StatefulWidget {
  const Stadiums({
    Key? key,
    required this.user,
    required this.onRefresh,
  }) : super(key: key);

  final UserData user;
  final Future<void> Function() onRefresh;

  @override
  State<Stadiums> createState() => _StadiumsState();
}

class _StadiumsState extends State<Stadiums> {
  String selectedType = 'all';

  @override
  Widget build(BuildContext context) {
    log('rebuild stadiums');
    log((ListStadiums?.length).toString());
    return FutureBuilder(
        future: getListStadiums(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Text(
                AppLocalizations.of(context)!.hi(widget.user.displayName!),
                style: GoogleFonts.poppins(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.stadiums_subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.headline3!.color,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                AppLocalizations.of(context)!.categories,
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
                  ChoiceCard(
                    value: 'all',
                    groupValue: selectedType,
                    icon: 'assets/images/both.svg',
                    label: AppLocalizations.of(context)!.all,
                    onTap: onTapCard,
                  ),
                  ChoiceCard(
                    value: 'padel',
                    groupValue: selectedType,
                    icon: 'assets/images/padel.svg',
                    label: AppLocalizations.of(context)!.padel,
                    onTap: onTapCard,
                  ),
                  ChoiceCard(
                    value: 'football',
                    groupValue: selectedType,
                    icon: 'assets/images/football.svg',
                    label: AppLocalizations.of(context)!.football,
                    onTap: onTapCard,
                  ),
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
                AppLocalizations.of(context)!.available_stadiums,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
              SizedBox(height: 10.h),
              ListStadiums.isNull
                  ? const LoadingTile()
                  : ListStadiums.isEmpty
                      ? const SizedBox.shrink()
                      : Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) =>
                                AvailableStadiumsTile(
                                    stadium: ListStadiums.list[index]),
                            separatorBuilder: (context, _) =>
                                SizedBox(height: 10.h),
                            itemCount: ListStadiums.length,
                          ),
                        ),
            ],
          );
        });
  }

  void onTapCard(String value) => setState(() {
        ListStadiums.reset();
        selectedType = value;
      });

  Future getListStadiums() async {
    await ListStadiums.getList(selectedType);
  }

  Future refreshListStadiums() async {
    await ListStadiums.refresh();
    setState(() {});
  }
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final String value;
  final String groupValue;
  final String icon;
  final String label;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(value),
      child: Container(
        width: (1.sw - 50) / 3,
        height: 80.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: groupValue == value
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: groupValue == value
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
                color: groupValue == value
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

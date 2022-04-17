import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/widgets/tiles.dart';
import 'package:padel/src/widgets/widget_models.dart';

class Stadiums extends StatefulWidget {
  const Stadiums({
    Key? key,
    required this.user,
    this.controller,
    required this.changeTab,
  }) : super(key: key);

  final UserData user;
  final ScrollController? controller;
  final void Function(int) changeTab;

  @override
  State<Stadiums> createState() => _StadiumsState();
}

class _StadiumsState extends State<Stadiums> {
  String selectedType = 'all';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getListStadiums(),
        builder: (context, snapshot) {
          return CustomScrollView(
            controller: widget.controller,
            slivers: [
              SliverToBoxAdapter(
                child: Text(
                  AppLocalizations.of(context)!.hi(widget.user.displayName!),
                  style: GoogleFonts.poppins(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headline1!.color,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  AppLocalizations.of(context)!.stadiums_subtitle,
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
                  child: Text(
                    AppLocalizations.of(context)!.categories,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Row(
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
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: const Image(
                      image: AssetImage('assets/images/banner.jpg'),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Text(
                    AppLocalizations.of(context)!.available_stadiums,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: ListStadiumsMax.isNull
                      ? const LoadingTile()
                      : ListStadiumsMax.isEmpty
                          ? EmptyListView(
                              text:
                                  AppLocalizations.of(context)!.empty_stadiums,
                              verticalPadding: 70.h,
                            )
                          : const SizedBox.shrink(),
                ),
              ),
              if (ListStadiumsMax.isNotNull && ListStadiumsMax.isNotEmpty)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => AvailableStadiumsTile(
                      user: widget.user,
                      stadium: ListStadiumsMax.list[index],
                      changeTab: widget.changeTab,
                    ),
                    childCount: ListStadiumsMax.length,
                  ),
                ),
            ],
          );
        });
  }

  void onTapCard(String value) => setState(() {
        ListStadiumsMax.reset();
        selectedType = value;
      });

  Future getListStadiums() async {
    await ListStadiumsMax.getList(selectedType);
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

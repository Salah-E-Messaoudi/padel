import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';
import 'package:padel/src/widgets/screens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final _bookingsController = ScrollController();

  @override
  void initState() {
    super.initState();
    ListBookings.uid = widget.user.uid;
    ListNotifications.uid = widget.user.uid;
    ListFriends.uid = widget.user.uid;
    ListPendingInvitations.uid = widget.user.uid;
    _bookingsController.addListener(() {
      if (!ListBookings.canGetMore || ListBookings.isLoading) return;
      if (_bookingsController.position.maxScrollExtent ==
          _bookingsController.offset) {
        ListBookings.getMore().then((_) {
          if (mounted) setState(() {});
        });
        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          StreamBuilder<bool>(
            stream:
                NotificationsService.getNotificationBadge(uid: widget.user.uid),
            builder: (context, snapshot) {
              return Badge(
                padding: snapshot.hasData && snapshot.data == true
                    ? EdgeInsets.all(5.sp)
                    : EdgeInsets.zero,
                badgeColor: Theme.of(context).primaryColor,
                position: BadgePosition.topEnd(top: 10.sp, end: 10.sp),
                child: IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Notifications(),
                    ),
                  ),
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Theme.of(context).textTheme.headline1!.color,
                    size: 26.sp,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: SideMenu(user: widget.user),
      body: RefreshIndicator(
        backgroundColor: const Color.fromARGB(245, 245, 245, 255),
        color: Theme.of(context).primaryColor,
        onRefresh: onRefresh,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: IndexedStack(
            index: currentIndex,
            children: [
              Stadiums(
                user: widget.user,
                changeTab: updateCurrentIndex,
              ),
              Bookings(
                user: widget.user,
                controller: _bookingsController,
                currentIndex: currentIndex,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 30,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() => currentIndex = index);
          },
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).textTheme.headline3!.color,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/stadiums.svg',
                color: currentIndex == 0
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.headline3!.color,
              ),
              label: AppLocalizations.of(context)!.stadiums,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/bookings.svg',
                color: currentIndex == 1
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.headline3!.color,
              ),
              label: AppLocalizations.of(context)!.bookings,
            )
          ]),
    );
  }

  void updateCurrentIndex(int index) {
    if (mounted) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  ScrollController? getScrollController() {
    switch (currentIndex) {
      case 0:
        return null;
      default:
        return null;
    }
  }

  Future<void> onRefresh() async {
    switch (currentIndex) {
      case 0:
        await ListStadiumsMax.refresh();
        break;
      case 1:
        if (ListBookings.isLoading) return;
        await ListBookings.refresh();
        break;
      default:
        return;
    }
    setState(() {});
  }
}

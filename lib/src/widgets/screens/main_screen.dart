import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenNotification(),
              ),
            ),
            icon: const Icon(
              Icons.notifications_outlined,
            ),
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
              Stadiums(user: widget.user),
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
        await ListStadiums.refresh();
        break;
      default:
        return;
    }
    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/src/widgets/screens/bookings.dart';
import 'package:padel/src/widgets/screens/notification.dart';
import 'package:padel/src/widgets/screens/side_menu.dart';
import 'package:padel/src/widgets/screens/stadiums.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final screens = [const Stadiums(), const Bookings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenNotification(),
                ),
              );
            },
            icon: Icon(
              Icons.notifications_outlined,
              color: Theme.of(context).textTheme.headline1!.color,
              size: 26.sp,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: IndexedStack(
            index: currentIndex,
            children: screens,
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
              label: 'Stadiums',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/bookings.svg',
                color: currentIndex == 1
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.headline3!.color,
              ),
              label: 'Bookings',
            )
          ]),
    );
  }
}

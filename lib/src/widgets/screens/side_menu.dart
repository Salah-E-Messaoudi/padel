import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/src/widgets/screens.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100.sp,
            width: 100.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 3),
            ),
            child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).textTheme.headline4!.color!,
                )),
          ),
          SizedBox(height: 15.h),
          Text(
            'Salah Eddine Messaoudi',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.headline1!.color,
            ),
          ),
          Text(
            '+965 2871 2942',
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.headline3!.color,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Divider(
                  thickness: 2,
                  color: Theme.of(context).textTheme.headline5!.color,
                ),
                SizedBox(height: 30.h),
                menuListItem(context, Icons.person_outline_rounded,
                    AppLocalizations.of(context)!.profile, const Profile()),
                menuListItem(
                    context,
                    Icons.people_outline_rounded,
                    AppLocalizations.of(context)!.my_friends,
                    const MyFriends()),
                menuListItem(
                    context,
                    Icons.person_add_alt_outlined,
                    AppLocalizations.of(context)!.pending_invitation,
                    const PendingInvitation()),
                menuListItem(
                    context,
                    Icons.assignment_outlined,
                    AppLocalizations.of(context)!.play_system,
                    const PlaySystem()),
                menuListItem(context, Icons.logout_rounded,
                    AppLocalizations.of(context)!.logout, const Profile()),
              ],
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget menuListItem(
      BuildContext context, IconData icon, String text, Widget screen) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).scaffoldBackgroundColor,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          if (text == 'Log Out') {
            print('logout');
          } else {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen));
          }
        },
        child: Row(
          children: [
            Icon(
              icon,
              size: 26.sp,
              color: Theme.of(context).textTheme.headline1!.color,
            ),
            SizedBox(width: 15.w),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.headline1!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

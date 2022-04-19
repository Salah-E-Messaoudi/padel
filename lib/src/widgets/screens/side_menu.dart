import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';
import 'package:padel/src/widgets/screens.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 120.h),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Profile(user: user)));
            },
            child: Column(
              children: [
                Container(
                  height: 100.sp,
                  width: 100.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 3,
                    ),
                  ),
                  child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundImage: user.photo,
                        backgroundColor:
                            Theme.of(context).textTheme.headline4!.color!,
                      )),
                ),
                SizedBox(height: 15.h),
                Text(
                  user.displayName!,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.headline1!.color,
                  ),
                ),
                Text(
                  user.phoneNumber!,
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.headline3!.color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).textTheme.headline5!.color,
                ),
                SizedBox(height: 30.h),
                CustomListTile(
                  text: AppLocalizations.of(context)!.profile,
                  icon: Icons.person_outline_rounded,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Profile(
                                user: user,
                              ))),
                ),
                CustomListTile(
                  text: AppLocalizations.of(context)!.my_friends,
                  icon: Icons.people_outline_rounded,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyFriends(
                        user: user,
                      ),
                    ),
                  ),
                ),
                CustomListTile(
                  text: AppLocalizations.of(context)!.pending_invitation,
                  icon: Icons.person_add_alt_outlined,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PendingInvitations(
                                user: user,
                              ))),
                ),
                CustomListTile(
                  text: AppLocalizations.of(context)!.play_system,
                  icon: Icons.assignment_outlined,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlaySystem())),
                ),
                CustomListTile(
                  text: AppLocalizations.of(context)!.logout,
                  icon: Icons.logout_rounded,
                  onPressed: () {
                    showAlertDialog(
                      context: context,
                      title: AppLocalizations.of(context)!.alert_signout_title,
                      content:
                          AppLocalizations.of(context)!.alert_signout_subtitle,
                      onYes: () => AuthenticationService.signOut(),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).scaffoldBackgroundColor,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          Navigator.pop(context);
          onPressed();
        },
        child: Row(
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: Theme.of(context).textTheme.headline1!.color,
            ),
            SizedBox(width: 15.w),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.headline1!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

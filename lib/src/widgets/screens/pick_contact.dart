import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/widgets/tiles.dart';
import 'package:padel/src/widgets/widget_models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

class PickContact extends StatelessWidget {
  const PickContact({
    Key? key,
    required this.onPick,
  }) : super(key: key);

  final void Function(String) onPick;

  Future<List<Contact>> getContacts(BuildContext context) async {
    late PermissionStatus serviceStatus;
    serviceStatus = await Permission.contacts.status;
    if (serviceStatus.isPermanentlyDenied) {
      dontHavePermission(context);
      return [];
    }
    if (!serviceStatus.isGranted) {
      await Permission.contacts.request();
      serviceStatus = await Permission.contacts.status;
      if (!serviceStatus.isGranted) {
        dontHavePermission(context);
        return [];
      }
    }
    return await FlutterContacts.getContacts(
      withProperties: true,
      withPhoto: true,
    );
  }

  void dontHavePermission(BuildContext context) {
    Navigator.pop(context);
    showOneButtonDialog(
      context: context,
      title: 'Need access to your contacts',
      content:
          'Give Padel Life permission to access your contacts list in order to activate this feature.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contact>>(
        future: getContacts(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            dontHavePermission(context);
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              height: 0.7.sh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5.sp, bottom: 10.sp),
                    width: 120.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.headline2!.color!,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.add_new_friend,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.select_contact,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.headline4!.color,
                    ),
                  ),
                  !snapshot.hasData || snapshot.data == null
                      ? const LoadingTile()
                      : snapshot.data!.isEmpty
                          ? EmptyListView(
                              text: AppLocalizations.of(context)!
                                  .empty_friends_myfriends,
                              topPadding: 50.h,
                            )
                          : Expanded(
                              child: ListView.separated(
                                itemCount: snapshot.data!.length,
                                padding: EdgeInsets.only(top: 10.h),
                                itemBuilder: (context, index) => ContactTile(
                                  contact: snapshot.data![index],
                                  onPick: onPick,
                                ),
                                separatorBuilder: (context, _) =>
                                    const CustomSeperator(),
                              ),
                            ),
                ],
              ),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyFriendsTile extends StatefulWidget {
  const MyFriendsTile({
    Key? key,
    required this.booking,
    required this.friend,
  }) : super(key: key);

  final Booking? booking;
  final Friend friend;

  @override
  State<MyFriendsTile> createState() => _MyFriendsTileState();
}

class _MyFriendsTileState extends State<MyFriendsTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28.sp,
                backgroundColor: Theme.of(context).textTheme.headline5!.color,
              ),
              SizedBox(width: 10.w),
              //TODO wrap text with expanded
              SizedBox(
                width: 1.sw - 160.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.friend.displayName,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                    ),
                    Text(
                      widget.friend.phoneNumber,
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.headline3!.color,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.booking != null)
                SizedBox(
                  width: 50.w,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (widget.booking!.hasUser(widget.friend.uid)) return;
                      showAlertDialog(
                          context: context,
                          title: 'Invite to match',
                          content:
                              'Would like to send this user an invitation to join this match',
                          onYes: () async {
                            try {
                              setState(() {
                                widget.booking!.inviteUser(widget.friend.uid);
                              });
                              //TODO implement send invitation
                              Future.delayed(const Duration(seconds: 1), () {});
                            } on Exception {
                              if (mounted) {
                                setState(() {
                                  widget.booking!
                                      .undoInviteUser(widget.friend.uid);
                                });
                              }
                              showSnackBarMessage(
                                context: context,
                                hintMessage:
                                    AppLocalizations.of(context)!.unknown_error,
                                icon: Icons.info_outline,
                              );
                            }
                          });
                    },
                    child: Text(
                      widget.booking!.isInvited(widget.friend.uid)
                          ? AppLocalizations.of(context)!.invited
                          : widget.booking!.isAdded(widget.friend.uid)
                              ? AppLocalizations.of(context)!.invited
                              : AppLocalizations.of(context)!.invite,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: widget.booking!.hasUser(widget.friend.uid)
                            ? Theme.of(context).textTheme.headline4!.color
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      primary: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Divider(
            thickness: 1.5,
            color: Theme.of(context).textTheme.headline5!.color!,
          ),
        )
      ],
    );
  }
}

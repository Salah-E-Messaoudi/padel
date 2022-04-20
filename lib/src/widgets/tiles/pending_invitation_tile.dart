import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';

class PendingInvitationTile extends StatelessWidget {
  const PendingInvitationTile({
    Key? key,
    required this.user,
    required this.invitation,
    required this.popInvitation,
  }) : super(key: key);

  final UserData user;
  final PendingInvitation invitation;
  final void Function(PendingInvitation) popInvitation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Theme.of(context).textTheme.headline5!.color!,
        ),
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22.sp,
                      backgroundColor:
                          Theme.of(context).textTheme.headline5!.color,
                      backgroundImage: invitation.owner.photo,
                    ),
                    SizedBox(width: 10.w),
                    SizedBox(
                      width: 1.sw - 200.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.invite_from,
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              height: 1,
                              color:
                                  Theme.of(context).textTheme.headline3!.color,
                            ),
                          ),
                          Text(
                            invitation.owner.displayName,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.event,
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.headline3!.color,
                          ),
                        ),
                        Text(
                          invitation.stadium.type == 'padel'
                              ? AppLocalizations.of(context)!.type_match(
                                  AppLocalizations.of(context)!.padel)
                              : AppLocalizations.of(context)!.type_match(
                                  AppLocalizations.of(context)!.football),
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline6!.color,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  invitation.stadium.address,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    height: 1,
                    color: Theme.of(context).textTheme.headline3!.color,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.time,
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.headline3!.color,
                          ),
                        ),
                        Text(
                          DateFormat('HH:mm')
                                  .format(invitation.details.startAt) +
                              ' - ' +
                              DateFormat('HH:mm')
                                  .format(invitation.details.endAt),
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 30.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.date,
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.headline3!.color,
                          ),
                        ),
                        Text(
                          DateFormat('EEE dd MMM')
                              .format(invitation.details.startAt),
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 30.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.team,
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.headline3!.color,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .number_joined(invitation.countText),
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Divider(
            thickness: 1.5,
            color: Theme.of(context).textTheme.headline5!.color,
            height: 1,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => showFutureAlertDialog(
                    context: context,
                    title: AppLocalizations.of(context)!.confirmation,
                    content: AppLocalizations.of(context)!
                        .alert_reject_invit_subtitle,
                    onYes: () async {
                      await PendingInvitationsService.ignore(
                        id: invitation.id,
                        uid: user.uid,
                      );
                    },
                    onComplete: () {
                      popInvitation(invitation);
                      showSnackBarMessage(
                        context: context,
                        hintMessage: AppLocalizations.of(context)!
                            .invitation_rejected_successfully,
                        icon: Icons.info_outline,
                      );
                    },
                    onException: (e) => showSnackBarMessage(
                      context: context,
                      hintMessage: AppLocalizations.of(context)!.unknown_error,
                      icon: Icons.info_outline,
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.reject,
                    style: GoogleFonts.poppins(
                      height: 1.2,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFC1111),
                    ),
                  ),
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                VerticalDivider(
                  color: Theme.of(context).textTheme.headline5!.color,
                  width: 1.5,
                  thickness: 1.5,
                ),
                TextButton(
                  onPressed: () => showFutureAlertDialog(
                    context: context,
                    title: AppLocalizations.of(context)!.confirmation,
                    content: AppLocalizations.of(context)!
                        .alert_accept_invit_subtitle,
                    onYes: () async {
                      await PendingInvitationsService.confirm(
                        id: invitation.id,
                        uid: user.uid,
                        photoURL: user.photoUrl!,
                      );
                    },
                    onComplete: () {
                      popInvitation(invitation);
                      showSnackBarMessage(
                        context: context,
                        hintMessage: AppLocalizations.of(context)!
                            .invitation_accepted_successfully,
                        icon: Icons.info_outline,
                      );
                    },
                    onException: (e) => showSnackBarMessage(
                      context: context,
                      hintMessage: AppLocalizations.of(context)!.unknown_error,
                      icon: Icons.info_outline,
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.accept,
                    style: GoogleFonts.poppins(
                      height: 1.2,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF278E67),
                    ),
                  ),
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

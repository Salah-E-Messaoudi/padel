import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFriendsTile extends StatefulWidget {
  const MyFriendsTile({Key? key, required this.invite}) : super(key: key);
  final bool invite;

  @override
  State<MyFriendsTile> createState() => _MyFriendsTileState();
}

class _MyFriendsTileState extends State<MyFriendsTile> {
  bool sending = false;
  bool sent = false;
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
              SizedBox(
                width: 1.sw - 160.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Khalid Ghazi',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                    ),
                    Text(
                      '+965 2997 5820',
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.headline3!.color,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.invite)
                // CustomIconTextButton(
                //   label: 'Invite',
                //   shadowColor: Colors.transparent,
                //   color: Theme.of(context).primaryColor,
                //   padding: EdgeInsets.zero,
                //   fixedSize: Size(60.w, 20.h),
                //   fontColor: Theme.of(context).primaryColor,
                //   onPressed: () {},
                // )
                SizedBox(
                  width: 50.w,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!sent && !sending) {
                        setState(() {
                          sending = true;
                        });
                        await Future.delayed(const Duration(seconds: 2));
                        //TODO send invite
                        setState(() {
                          sending = false;
                          sent = true;
                        });
                      }
                    },
                    child: Text(
                      sent
                          ? 'sent'
                          : sending
                              ? 'sending'
                              : 'invite',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: sending
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

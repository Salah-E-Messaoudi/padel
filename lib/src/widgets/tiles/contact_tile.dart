import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key? key,
    required this.contact,
    required this.onPick,
  }) : super(key: key);

  final Contact contact;
  final void Function(String) onPick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: InkWell(
        onTap: () {
          if (contact.phones.isEmpty) {
            return;
          }
          onPick(contact.phones.first.number
              .replaceAll(RegExp(r'(^\)|\(|\s|-)'), ''));
          Navigator.pop(context);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 26.sp,
              backgroundColor: Theme.of(context).textTheme.headline5!.color,
              backgroundImage: contact.photo == null
                  ? null
                  : Image.memory(contact.photo!).image,
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.displayName,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                  if (contact.phones.isNotEmpty)
                    Text(
                      contact.phones.first.number,
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.headline3!.color,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.open_in_new,
              color: Theme.of(context).textTheme.headline1!.color,
              size: 20.sp,
            )
          ],
        ),
      ),
    );
  }
}

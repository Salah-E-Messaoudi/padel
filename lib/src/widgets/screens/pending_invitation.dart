import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/src/widgets/tiles/pending_invitation_tile.dart';

class PendingInvitation extends StatelessWidget {
  const PendingInvitation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Pending Invitation',
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            color: Theme.of(context).textTheme.headline1!.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: const [PendingInvitationTile()],
      ),
    );
  }
}

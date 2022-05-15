import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PickLanguage extends StatelessWidget {
  const PickLanguage({
    Key? key,
    required this.setLocale,
  }) : super(key: key);

  final void Function(Locale) setLocale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image:
                    const AssetImage('assets/images/App installation-bro.png'),
                width: 0.85.sw,
              ),
            ),
            SizedBox(height: 60.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pick your\nlanguage',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).textTheme.headline1!.color,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                Text(
                  'اختر اللغة\nالخاصة بك',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).textTheme.headline1!.color,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => setLocale(const Locale('en')),
                  child: Text(
                    'English',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      height: 1.2,
                    ),
                  ),
                ),
                Text(
                  '  -  ',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).textTheme.headline1!.color,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                TextButton(
                  onPressed: () => setLocale(const Locale('ar')),
                  child: Text(
                    'العربية',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

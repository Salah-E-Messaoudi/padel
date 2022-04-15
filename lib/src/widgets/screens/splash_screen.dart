import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
    required this.loading,
    this.isOverlayed = false,
  }) : super(key: key);

  final bool loading;
  final bool isOverlayed;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loading,
      child: Scaffold(
        backgroundColor: isOverlayed
            ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)
            : Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Column(
            children: [
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: SvgPicture.asset(
                  'assets/images/padel_logo.svg',
                  fit: BoxFit.contain,
                  width: 0.7.sw,
                  height: 0.3.sh,
                ),
              ),
              SpinKitSpinningLines(
                color: Theme.of(context).primaryColor,
                size: 50.sp,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

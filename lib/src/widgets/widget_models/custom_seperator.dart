import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSeperator extends StatelessWidget {
  const CustomSeperator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Divider(
        thickness: 1.5,
        height: 1.5,
        color: Theme.of(context).textTheme.headline5!.color!,
      ),
    );
  }
}

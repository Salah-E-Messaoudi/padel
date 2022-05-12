import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingTile extends StatelessWidget {
  const LoadingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 25.h,
            ),
            Container(
              height: 43.h,
              width: 43.h,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color.fromARGB(245, 245, 245, 255),
                shape: BoxShape.circle,
              ),
              child: SpinKitRing(
                color: Theme.of(context).primaryColor,
                size: 20.h,
                lineWidth: 2.3.h,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

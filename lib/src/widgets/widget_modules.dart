import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomIconTextButton extends StatelessWidget {
  const CustomIconTextButton(
      {Key? key,
      required this.label,
      this.color,
      this.disabledcolor,
      this.icon,
      this.onPressed,
      this.fontSize = 20,
      this.fixedSize,
      this.fontColor,
      this.iconColor,
      this.shadowColor,
      this.borderColor,
      this.minimumSize,
      this.iconSize = 20,
      this.padding,
      this.borderRadius,
      this.loading = false,
      this.enabled = true,
      this.toUpperCase = false})
      : super(key: key);

  final String label;
  final IconData? icon;
  final Color? color;
  final Color? disabledcolor;
  final Size? minimumSize;
  final double iconSize;
  final Size? fixedSize;
  final double fontSize;
  final Color? fontColor;
  final Color? iconColor;
  final Color? shadowColor;
  final Color? borderColor;
  final bool toUpperCase;
  final bool loading;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 20.sp),
            minimumSize: minimumSize ?? Size(0.25.sw, 35.sp),
            fixedSize: fixedSize,
            primary: !enabled
                ? disabledcolor ?? Theme.of(context).textTheme.headline3!.color
                : color ?? Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(50.sp),
              side: BorderSide(
                color: borderColor ?? Colors.transparent,
                width: 2.0,
              ),
            ),
            shadowColor: shadowColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: loading
                ? [
                    SpinKitWave(
                      color: iconColor ?? fontColor,
                      size: ((minimumSize?.height ?? 35) - 10).sp,
                    )
                  ]
                : [
                    if (icon != null)
                      Icon(icon,
                          color: iconColor ??
                              Theme.of(context).scaffoldBackgroundColor,
                          size: iconSize.sp),
                    if (icon != null) SizedBox(width: 6.sp),
                    Text(toUpperCase ? label.toUpperCase() : label,
                        style: GoogleFonts.poppins(
                          fontSize: fontSize.sp,
                          color: fontColor ??
                              Theme.of(context).scaffoldBackgroundColor,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
          ),
          onPressed: enabled ? onPressed : () {}),
    );
  }
}

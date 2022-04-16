import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    Key? key,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.enabled,
    required this.onChanged,
  }) : super(key: key);

  final String text;
  final String value;
  final String? groupValue;
  final bool enabled;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Theme.of(context).textTheme.headline1!.color,
          ),
          child: Radio(
            activeColor: Theme.of(context).primaryColor,
            value: value,
            groupValue: groupValue,
            onChanged: enabled ? onChanged : null,
          ),
        ),
        InkWell(
          onTap: () => onChanged(value),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.headline1!.color,
            ),
          ),
        ),
      ],
    );
  }
}

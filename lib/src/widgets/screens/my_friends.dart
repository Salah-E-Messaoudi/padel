import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/src/widgets/tiles/my_friends_tile.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/widgets/widget_models/custom_textformfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/src/widgets/widget_modules.dart';

class MyFriends extends StatelessWidget {
  const MyFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.my_friends,
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            color: Theme.of(context).textTheme.headline1!.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.sp),
                  topRight: Radius.circular(10.sp),
                ),
              ),
              context: context,
              builder: (context) => const AddFriend(),
            ),
            icon: Icon(
              Icons.add_rounded,
              color: Theme.of(context).textTheme.headline1!.color,
              size: 26.sp,
            ),
          ),
        ],
      ),
      body: Column(
        children: const [MyFriendsTile(), MyFriendsTile()],
      ),
    );
  }
}

class AddFriend extends StatefulWidget {
  const AddFriend({Key? key}) : super(key: key);

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  final GlobalKey<FormState> _keyA = GlobalKey();
  String phoneCode = '+965';
  String countryCode = 'KW';
  String countryName = 'Kuwait';
  bool loading = false;
  bool verification = false;
  String? phonenumber;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.add_new_friend,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.headline1!.color,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.add_new_friend_subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.headline4!.color,
            ),
          ),
          SizedBox(height: 30.h),
          Form(
            key: _keyA,
            autovalidateMode: AutovalidateMode.disabled,
            child: CustomTextFormField(
              hint: AppLocalizations.of(context)!.phone_number_hint,
              hintStyle: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.headline3!.color),
              prefix: CountryCodePicker(
                onChanged: (code) {
                  countryCode = code.code ?? 'KW';
                  phoneCode = code.dialCode ?? '+965';
                  countryName = code.name ?? 'Kuwait';
                },
                initialSelection: countryCode,
                favorite: const ['KW'],
                countryFilter: const ['KW'],
                enabled: false,
                comparator: (a, b) => b.name!.compareTo(a.name!),
                boxDecoration: BoxDecoration(
                  color: Theme.of(context).textTheme.headline4!.color,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                textStyle: GoogleFonts.poppins(
                  height: 1.6,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.headline3!.color,
                  fontSize: 14.sp,
                ),
                padding: EdgeInsets.zero,
                flagWidth: 26.sp,
              ),
              style: GoogleFonts.poppins(
                height: 2.1,
                color: Theme.of(context).textTheme.headline1!.color,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              onSaved: (value) {
                phonenumber = value;
              },
              validator: (value) =>
                  validateNumberInt(value: value, context: context),
              errorText: getError(context, _error),
              width: 0.8.sw,
              keyboardType: TextInputType.phone,
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.sp, vertical: 8.sp),
              fontSize: 20.sp,
              enabled: !loading,
              onEditingComplete: next,
            ),
          ),
          SizedBox(height: 30.h),
          CustomIconTextButton(
            label: AppLocalizations.of(context)!.add_friends,
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(50),
            fontColor: Theme.of(context).scaffoldBackgroundColor,
            loading: loading,
            fixedSize: Size(0.4.sw, 40.h),
            enabled: !loading,
            fontSize: 16.sp,
            onPressed: () {
              if (_keyA.currentState!.validate()) {}
            },
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  void next() async {
    setState(() {
      verification = !verification;
    });
    // return;
    // if (verificationId != null &&
    //     forceResendingToken != null &&
    //     pinCode != null) {
    //   await onComplete(pinCode!);
    // } else if (!verification) {
    //   if (_keyA.currentState != null && _keyA.currentState!.validate()) {
    //     _keyA.currentState!.save();
    //     if (await validatePhoneNumber()) {
    //       await verifyPhoneNumber();
    //     } else {
    //       setState(() {
    //         _error = 'invalid-phone-number';
    //       });
    //     }
    //   }
    // }
  }
}

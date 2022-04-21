import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';
import 'package:padel/src/widgets/widget_models.dart';
import 'package:phone_number/phone_number.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({
    Key? key,
    required this.user,
    required this.rebuildScreen,
  }) : super(key: key);

  final UserData user;
  final void Function() rebuildScreen;

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  final GlobalKey<FormState> _keyA = GlobalKey();
  String phoneCode = '+213'; //'+965';
  String countryCode = 'DZ'; //'KW';
  String countryName = 'Algeria'; //'Kuwait';
  bool loading = false;
  bool verification = false;
  String? phonenumber;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  hint: AppLocalizations.of(context)!.phone_number_hint,
                  prefix: CountryCodePicker(
                    onChanged: (code) {
                      countryCode = code.code ?? 'KW';
                      phoneCode = code.dialCode ?? '+965';
                      countryName = code.name ?? 'Kuwait';
                    },
                    initialSelection: countryCode,
                    enabled: false,
                    comparator: (a, b) => b.name!.compareTo(a.name!),
                    boxDecoration: BoxDecoration(
                      color: Theme.of(context).textTheme.headline4!.color,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    textStyle: GoogleFonts.poppins(
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.headline3!.color,
                      fontSize: 16.sp,
                    ),
                    padding: EdgeInsets.zero,
                    flagWidth: 26.sp,
                  ),
                  style: GoogleFonts.poppins(
                      height: 1,
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                  onSaved: (value) {
                    phonenumber = value;
                  },
                  validator: (value) =>
                      validateNotNull(value: value, context: context),
                  errorText: getError(context, _error),
                  width: 0.8.sw,
                  keyboardType: TextInputType.phone,
                  contentPadding: EdgeInsets.symmetric(vertical: 16.sp),
                  fontSize: 16,
                  enabled: !loading,
                  onEditingComplete: next,
                ),
              ],
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
            onPressed: next,
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  Future<void> next() async {
    FocusScope.of(context).unfocus();
    if (loading) return;
    try {
      if (_keyA.currentState != null && _keyA.currentState!.validate()) {
        _keyA.currentState!.save();
        if (await validatePhoneNumber()) {
          setState(() {
            loading = true;
            _error = null;
          });
          showFutureAlertDialog(
              context: context,
              title: AppLocalizations.of(context)!.confirmation,
              content: AppLocalizations.of(context)!.alert_add_friend_subtitle,
              onYes: () async {
                await FriendsService.addFriend(
                  user: widget.user,
                  phoneNumber: phonenumber!,
                );
              },
              onComplete: () async {
                widget.rebuildScreen();
                Navigator.pop(context);
                showSnackBarMessage(
                  context: context,
                  hintMessage:
                      AppLocalizations.of(context)!.friend_added_successfully,
                  icon: Icons.info_outline,
                );
              },
              onException: (err) {
                Navigator.pop(context);
                if (err is CFException) {
                  showSnackBarMessage(
                    context: context,
                    hintMessage: getError(context, err.code!)!,
                    icon: Icons.info_outline,
                  );
                } else {
                  showSnackBarMessage(
                    context: context,
                    hintMessage: AppLocalizations.of(context)!.unknown_error,
                    icon: Icons.info_outline,
                  );
                }
              });
        } else {
          setState(() {
            _error = 'invalid-phone-number';
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
        showSnackBarMessage(
          context: context,
          hintMessage: getError(context, e.code)!,
          icon: Icons.info_outline,
        );
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      showSnackBarMessage(
        context: context,
        hintMessage: AppLocalizations.of(context)!.unknown_error,
        icon: Icons.info_outline,
      );
    }
  }

  Future<bool> validatePhoneNumber() async {
    try {
      bool isValid =
          await PhoneNumberUtil().validate(phonenumber!, countryCode);
      if (isValid) {
        PhoneNumber phoneNumber = await PhoneNumberUtil()
            .parse(phonenumber!, regionCode: countryCode);
        phonenumber = phoneNumber.international;
      }
      return isValid;
    } on Exception catch (_) {
      return false;
    }
  }
}

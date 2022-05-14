import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';
import 'package:padel/src/widgets/screens.dart';
import 'package:padel/src/widgets/widget_models.dart';
import 'package:phone_number/phone_number.dart';
import 'package:share_plus/share_plus.dart';

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
  TextEditingController controller = TextEditingController();
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
      padding: EdgeInsets.fromLTRB(20.w, 5.sp, 20.w, 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.sp),
            width: 120.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Theme.of(context).textTheme.headline2!.color!,
              borderRadius: BorderRadius.circular(10.sp),
            ),
          ),
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
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.headline4!.color,
            ),
          ),
          SizedBox(height: 10.h),
          Form(
            key: _keyA,
            autovalidateMode: AutovalidateMode.disabled,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomTextFormField(
                    suffixIcon: Icons.contacts,
                    suffixOnTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        enableDrag: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.sp),
                            topRight: Radius.circular(10.sp),
                          ),
                        ),
                        context: context,
                        builder: (context) => PickContact(
                          onPick: (value) => controller.text = value,
                        ),
                      );
                    },
                    controller: controller,
                    prefix: CountryCodePicker(
                      onChanged: (code) {
                        countryCode = code.code ?? 'KW';
                        phoneCode = code.dialCode ?? '+965';
                        countryName = code.name ?? 'Kuwait';
                      },
                      initialSelection: countryCode,
                      enabled: true,
                      favorite: const ['+965'],
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
                      fontWeight: FontWeight.bold,
                    ),
                    onSaved: (value) {
                      phonenumber = value;
                    },
                    validator: (value) =>
                        validateNotNull(value: value, context: context),
                    errorText: getError(context, _error),
                    width: 0.7.sw,
                    keyboardType: TextInputType.phone,
                    contentPadding: EdgeInsets.symmetric(vertical: 16.sp),
                    fontSize: 16,
                    enabled: !loading,
                    onEditingComplete: next,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
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
                if (err is CFException) {
                  if (err.code == 'user-not-found') {
                    setState(() {
                      loading = false;
                    });
                    showAlertDialog(
                      context: context,
                      title: AppLocalizations.of(context)!
                          .alert_send_invitation_title,
                      content: AppLocalizations.of(context)!
                          .alert_send_invitation_subtitle,
                      onYes: () async {
                        Share.share(
                          AppLocalizations.of(context)!.alert_share_invitation,
                          subject: 'Download and join Padel Life now',
                        );
                      },
                    );
                  } else {
                    Navigator.pop(context);
                    showSnackBarMessage(
                      context: context,
                      hintMessage: getError(context, err.code!)!,
                      icon: Icons.info_outline,
                    );
                  }
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

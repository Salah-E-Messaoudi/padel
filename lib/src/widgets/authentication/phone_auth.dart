import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/src/services_models/services.dart';
import 'package:padel/src/widgets/widget_models.dart';
import 'package:phone_number/phone_number.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:padel/functions.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  String? phonenumber;
  String? _error;
  bool loading = false;
  String phoneCode = '+213'; //'+965';
  String countryCode = 'DZ'; //'KW';
  String countryName = 'Algeria'; //'Kuwait';
  final GlobalKey<FormState> _keyA = GlobalKey();
  // ConfirmationResult? result;
  String? verificationId;
  int? forceResendingToken;
  String? pinCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80.h),
              SizedBox(
                child: Column(
                  children: [
                    CustomImageTextHeader(
                      title: AppLocalizations.of(context)!.auth_title,
                      subtitle: AppLocalizations.of(context)!.auth_subtitle,
                    ),
                    SizedBox(
                      height: 0.2.sh,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (otpSent)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 35.w),
                              child: PinCodeTextField(
                                enabled: !loading,
                                appContext: context,
                                length: 6,
                                onChanged: (value) {},
                                onCompleted: onComplete,
                                keyboardType: TextInputType.number,
                                textStyle: GoogleFonts.montserrat(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .color,
                                ),
                                pinTheme: PinTheme(
                                  borderWidth: 2.sp,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(20.sp),
                                  fieldHeight: 50.w,
                                  fieldWidth: 50.w,
                                  inactiveColor: Theme.of(context).primaryColor,
                                  activeColor: Theme.of(context).primaryColor,
                                  selectedColor: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          if (otpNotSent)
                            SizedBox(
                              width: 0.8.sw,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.phone_number,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Form(
                                    key: _keyA,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    child: CustomTextFormField(
                                      hint: AppLocalizations.of(context)!
                                          .phone_number_hint,
                                      prefix: CountryCodePicker(
                                        onChanged: (code) {
                                          countryCode = code.code ?? 'KW';
                                          phoneCode = code.dialCode ?? '+965';
                                          countryName = code.name ?? 'Kuwait';
                                        },
                                        initialSelection: countryCode,
                                        enabled: false,
                                        comparator: (a, b) =>
                                            b.name!.compareTo(a.name!),
                                        boxDecoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .color,
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                        ),
                                        textStyle: GoogleFonts.poppins(
                                          height: 1,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .color,
                                          fontSize: 16.sp,
                                        ),
                                        padding: EdgeInsets.zero,
                                        flagWidth: 26.sp,
                                      ),
                                      style: GoogleFonts.poppins(
                                          height: 1,
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .color,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                      onSaved: (value) {
                                        phonenumber = value;
                                      },
                                      validator: (value) => validateNumberInt(
                                          value: value, context: context),
                                      errorText: getError(context, _error),
                                      width: 0.8.sw,
                                      keyboardType: TextInputType.phone,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 16.sp),
                                      fontSize: 16,
                                      enabled: !loading,
                                      onEditingComplete: next,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (otpSent)
                            SizedBox(
                              width: 1.sw - 40.sp,
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 20.sp),
                                child: TextButton(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .didnt_receive_code,
                                        style: GoogleFonts.montserrat(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .color,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.resend,
                                        style: GoogleFonts.montserrat(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: verifyPhoneNumber,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        child: CustomIconTextButton(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderColor: Theme.of(context).primaryColor,
                          shadowColor: Colors.transparent,
                          label: otpSent
                              ? AppLocalizations.of(context)!.submit
                              : AppLocalizations.of(context)!.signin,
                          fontColor: Theme.of(context).primaryColor,
                          onPressed: () => next(),
                          fontSize: 14.sp,
                          loading: loading,
                        ),
                      ),
                      if (otpSent)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              verificationId = null;
                              forceResendingToken = null;
                            });
                          },
                          child: Text(
                            AppLocalizations.of(context)!.change_phone_number,
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).textTheme.headline3!.color,
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ]),
      ),
    );
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

  bool get otpSent => verificationId != null; // && forceResendingToken != null;
  bool get otpNotSent => !otpSent;

  void next() async {
    FocusScope.of(context).unfocus();
    if (loading) return;
    try {
      if (otpSent && pinCode != null) {
        await onComplete(pinCode!);
      } else if (otpNotSent) {
        if (_keyA.currentState != null && _keyA.currentState!.validate()) {
          _keyA.currentState!.save();
          if (await validatePhoneNumber()) {
            await verifyPhoneNumber();
          } else {
            setState(() {
              _error = 'invalid-phone-number';
            });
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
        if (!otpSent) {
          _error = e.code;
        }
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

  Future<void> verifyPhoneNumber() async {
    setState(() {
      loading = true;
      _error = null;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phonenumber!,
        verificationCompleted: (credential) async {},
        verificationFailed: (firebaseAuthException) {
          setState(() {
            loading = false;
            _error = firebaseAuthException.code;
          });
          showSnackBarMessage(
            context: context,
            hintMessage: getError(context, firebaseAuthException.code)!,
            icon: Icons.info_outline,
          );
        },
        codeSent: (id, token) {
          setState(() {
            verificationId = id;
            forceResendingToken = token;
            loading = false;
          });
        },
        codeAutoRetrievalTimeout: (value) {},
        forceResendingToken: forceResendingToken);
  }

  Future<void> onComplete(String pincode) async {
    pinCode = pincode;
    FocusScope.of(context).unfocus();
    setState(() {
      loading = true;
      _error = null;
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: pincode,
    );
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((userCredential) async {
      await UserInfoService.createUserInfo(userCredential);
    });
  }
}

class CustomImageTextHeader extends StatelessWidget {
  const CustomImageTextHeader(
      {Key? key, required this.title, required this.subtitle})
      : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/padel_logo.svg',
            width: 0.55.sw,
          ),
          SizedBox(height: 40.h),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Theme.of(context).textTheme.headline1!.color,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: Theme.of(context).textTheme.headline4!.color,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}

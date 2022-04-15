import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/widgets/widget_models/custom_textformfield.dart';
import 'package:padel/src/widgets/widget_modules.dart';
import 'package:image_picker/image_picker.dart';

class SetupAccount extends StatefulWidget {
  const SetupAccount({Key? key}) : super(key: key);

  @override
  State<SetupAccount> createState() => _SetupAccountState();
}

class _SetupAccountState extends State<SetupAccount> {
  final GlobalKey<FormState> _keyA = GlobalKey();
  late String gender = '';
  late String fullName;
  late int age;
  late bool genderSelected = true;
  File? image;

  Future imagePicker() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final selectedImage = File(image.path);
      setState(() => this.image = selectedImage);
    } on PlatformException catch (e) {
      log('Fieled to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 0.8.sh,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 40.h),
                    Text(
                      AppLocalizations.of(context)!.setup_account,
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).textTheme.headline1!.color,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      AppLocalizations.of(context)!.setup_account_subtitle,
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).textTheme.headline4!.color,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.h),
                    Stack(
                      children: [
                        Container(
                          height: 120.sp,
                          width: 120.sp,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 3),
                          ),
                          child: image == null
                              ? Center(
                                  child: Icon(
                                    Icons.person_outline_rounded,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .color,
                                    size: 70.sp,
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: FileImage(image!),
                                  )),
                        ),
                        Positioned(
                          bottom: 3.h,
                          right: 10.w,
                          child: InkWell(
                            onTap: () {
                              imagePicker();
                            },
                            child: Container(
                              height: 25.sp,
                              width: 25.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add_rounded,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  size: 24.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    Form(
                      key: _keyA,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.full_name,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          CustomTextFormField(
                            hint: AppLocalizations.of(context)!.full_name_hint,
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .color),
                            style: GoogleFonts.poppins(
                              height: 2.1,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            keyboardType: TextInputType.text,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                            width: 0.7.sw,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.sp,
                              vertical: 8.sp,
                            ),
                            fontSize: 20.sp,
                            validator: (value) =>
                                validateNotNull(value: value, context: context),
                            onSaved: (value) {
                              if (value != null) {
                                setState(() {
                                  fullName = value;
                                });
                              }
                            },
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            AppLocalizations.of(context)!.age,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          CustomTextFormField(
                            hint: AppLocalizations.of(context)!.age_hint,
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .color),
                            style: GoogleFonts.poppins(
                              height: 2.1,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            keyboardType: TextInputType.number,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                            width: 0.5.sw,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.sp, vertical: 8.sp),
                            fontSize: 20.sp,
                            validator: (value) =>
                                validateNotNull(value: value, context: context),
                            onSaved: (value) {
                              if (value != null) {
                                setState(() {
                                  age = int.parse(value);
                                });
                              }
                            },
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            AppLocalizations.of(context)!.gender,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              radioButton(AppLocalizations.of(context)!.male),
                              SizedBox(width: 40.w),
                              radioButton(AppLocalizations.of(context)!.female),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconTextButton(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderColor: Theme.of(context).primaryColor,
                    shadowColor: Colors.transparent,
                    label: AppLocalizations.of(context)!.confirme,
                    fontColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_keyA.currentState!.validate()) {
                        if (gender == '') {
                          setState(() => genderSelected = false);
                        } else {
                          setState(() {});
                        }
                      }
                    },
                    fontSize: 14.sp,
                    // loading: loading,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row radioButton(String value) {
    return Row(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: genderSelected == false
                ? Colors.red
                : Theme.of(context).textTheme.headline3!.color,
          ),
          child: Radio(
            activeColor: Theme.of(context).primaryColor,
            value: value,
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value.toString();
              });
            },
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

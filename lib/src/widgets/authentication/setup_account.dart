import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:padel/functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';
import 'package:padel/src/widgets/widget_models.dart';

class SetupAccount extends StatefulWidget {
  const SetupAccount({
    Key? key,
    required this.user,
    required this.rebuildWrapper,
  }) : super(key: key);

  final UserData user;
  final void Function() rebuildWrapper;

  @override
  State<SetupAccount> createState() => _SetupAccountState();
}

class _SetupAccountState extends State<SetupAccount> {
  final GlobalKey<FormState> _keyA = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  String? gender;
  String? displayName;
  String? birthDate;
  File? image;
  bool loading = false;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100.h),
              SizedBox(
                height: 0.75.sh,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                    InkWell(
                      onTap: loading ? null : imagePicker,
                      child: Stack(
                        children: [
                          Container(
                            height: 120.sp,
                            width: 120.sp,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
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
                                    ),
                                  ),
                          ),
                          Positioned(
                            bottom: 3.h,
                            right: 10.w,
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
                        ],
                      ),
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
                            keyboardType: TextInputType.name,
                            width: 0.7.sw,
                            validator: (value) =>
                                validateNotNull(value: value, context: context),
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              if (value != null) {
                                displayName = value;
                              }
                            },
                            enabled: !loading,
                          ),
                          Text(
                            AppLocalizations.of(context)!.age,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          CustomTextFormField(
                            controller: _controller,
                            hint: AppLocalizations.of(context)!.age_hint,
                            keyboardType: TextInputType.number,
                            width: 0.4.sw,
                            validator: (value) =>
                                validateNotNull(value: value, context: context),
                            textInputAction: TextInputAction.done,
                            onSaved: (value) {
                              birthDate = value;
                            },
                            enabled: !loading,
                            readOnly: true,
                            onTap: () {
                              DatePicker.showDatePicker(
                                context,
                                theme: DatePickerTheme(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  cancelStyle: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .color,
                                  ),
                                  doneStyle: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  itemStyle: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .color,
                                  ),
                                ),
                                showTitleActions: true,
                                maxTime: DateTime.now()
                                    .subtract(const Duration(days: 365 * 13)),
                                onConfirm: onPickBirthDate,
                                currentTime: selectedDate,
                                locale: LocaleType.en,
                              );
                            },
                          ),
                          Text(
                            AppLocalizations.of(context)!.gender,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              CustomRadioButton(
                                text: AppLocalizations.of(context)!.male,
                                value: 'male',
                                groupValue: gender,
                                enabled: !loading,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                              ),
                              SizedBox(width: 40.w),
                              CustomRadioButton(
                                text: AppLocalizations.of(context)!.female,
                                value: 'female',
                                groupValue: gender,
                                enabled: !loading,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                              ),
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
                    label:
                        (AppLocalizations.of(context)!.confirm).toUpperCase(),
                    fontColor: Theme.of(context).primaryColor,
                    onPressed: () async {
                      try {
                        if (loading) return;
                        FocusScope.of(context).unfocus();
                        if (image == null) {
                          showSnackBarMessage(
                            context: context,
                            hintMessage: getError(
                              context,
                              AppLocalizations.of(context)!.pick_image,
                            )!,
                            icon: Icons.info_outline,
                          );
                          return;
                        }
                        if (!_keyA.currentState!.validate()) {
                          return;
                        }
                        if (gender == null) {
                          showSnackBarMessage(
                            context: context,
                            hintMessage: getError(
                              context,
                              AppLocalizations.of(context)!.pick_gender,
                            )!,
                            icon: Icons.info_outline,
                          );
                          return;
                        }
                        setState(() {
                          loading = true;
                        });
                        _keyA.currentState!.save();
                        await UserInfoService.completeRegiration(
                          user: widget.user,
                          displayName: displayName!,
                          gender: gender!,
                          birthDate: birthDate!,
                          image: image!,
                        );
                        widget.rebuildWrapper();
                      } catch (e) {
                        showSnackBarMessage(
                          context: context,
                          hintMessage:
                              AppLocalizations.of(context)!.unknown_error,
                        );
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    fontSize: 14.sp,
                    loading: loading,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPickBirthDate(DateTime date) {
    birthDate =
        '${date.year}-${NumberFormat('00').format(date.month)}-${NumberFormat('00').format(date.day)}';
    selectedDate = date;
    _controller.text = birthDate!;
  }

  Future<void> imagePicker() async {
    XFile? selectedfile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedfile != null) {
      File? croppedFile = await ImageCropper().cropImage(
          sourcePath: selectedfile.path,
          maxWidth: 300,
          maxHeight: 300,
          compressFormat: ImageCompressFormat.png,
          cropStyle: CropStyle.circle,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          androidUiSettings: AndroidUiSettings(
              activeControlsWidgetColor: Theme.of(context).primaryColor,
              toolbarTitle: AppLocalizations.of(context)!.cropper,
              toolbarColor: Theme.of(context).primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
            title: AppLocalizations.of(context)!.cropper,
          ));
      if (croppedFile != null) {
        setState(() {
          image = croppedFile;
        });
      }
    }
  }
}

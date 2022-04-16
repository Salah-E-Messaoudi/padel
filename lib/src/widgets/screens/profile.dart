import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';
import 'package:padel/src/widgets/widget_models.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _keyA = GlobalKey();
  File? image;
  bool isEditing = false;
  bool loading = false;
  String? gender, displayName;
  int? age;

  @override
  void initState() {
    super.initState();
    gender = widget.user.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            color: Theme.of(context).textTheme.headline1!.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _keyA,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            SizedBox(height: 50.h),
            InkWell(
              onTap: loading ? null : imagePicker,
              child: Container(
                height: 120.sp,
                width: 120.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3),
                ),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).textTheme.headline5!.color,
                    backgroundImage:
                        image != null ? FileImage(image!) : widget.user.photo,
                  ),
                ),
              ),
            ),
            SizedBox(height: 60.h),
            ProfileInfo(
              icon: Icons.badge_outlined,
              label: AppLocalizations.of(context)!.full_name,
              value: widget.user.displayName!,
              enabled: isEditing,
              validator: (value) =>
                  validateNotNull(value: value, context: context),
              onSaved: (value) => displayName = value,
            ),
            ProfileInfo(
              icon: Icons.call_outlined,
              label: AppLocalizations.of(context)!.phone_number,
              value: widget.user.phoneNumber!,
              enabled: false,
              validator: (value) =>
                  validateNotNull(value: value, context: context),
            ),
            DropDownGender(
                icon: Icons.male,
                label: AppLocalizations.of(context)!.gender,
                groupValue: gender,
                enabled: isEditing,
                onChanged: (value) => setState(() {
                      gender = value;
                    })),
            ProfileInfo(
              icon: Icons.person_outline_rounded,
              label: AppLocalizations.of(context)!.age,
              value: widget.user.age!.toString(),
              enabled: isEditing,
              width: 80.w,
              validator: (value) =>
                  validateNumberInt(value: value, context: context),
              onSaved: (value) => age = int.parse(value!),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomIconTextButton(
        label: isEditing
            ? AppLocalizations.of(context)!.save_profile
            : AppLocalizations.of(context)!.edit_profile,
        onPressed: toggleState,
        fontColor: Colors.white,
        icon: isEditing ? Icons.save_outlined : Icons.edit_outlined,
        fixedSize: Size(0.45.sw, 40.sp),
        loading: loading,
      ),
    );
  }

  Future<void> toggleState() async {
    try {
      if (isEditing) {
        if (!_keyA.currentState!.validate()) return;
        _keyA.currentState!.save();
        if (image == null &&
            widget.user.displayName == displayName &&
            widget.user.age == age &&
            widget.user.gender == gender) return;
        showFutureAlertDialog(
            context: context,
            title: 'Update profile',
            content:
                'Are you sure you want to update your personnel information??',
            onYes: () async {
              await UserInfoService.updateUserInfo(
                user: widget.user,
                displayName: displayName!,
                gender: gender!,
                age: age!,
                image: image,
              );
            },
            onComplete: () {
              setState(() {
                isEditing = !isEditing;
              });
              if (mounted) {
                showSnackBarMessage(
                    context: context,
                    hintMessage: 'update completed!',
                    icon: Icons.check_circle_outline_outlined);
              }
            });
      } else {
        setState(() {
          isEditing = !isEditing;
        });
      }
    } on Exception {
      if (mounted) {
        showSnackBarMessage(
          context: context,
          hintMessage: AppLocalizations.of(context)!.unknown_error,
          icon: Icons.info_outline,
        );
      }
    }
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
              toolbarTitle: 'Cropper',
              toolbarColor: Theme.of(context).primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1.0,
            title: 'Cropper',
          ));
      if (croppedFile != null) {
        setState(() {
          image = croppedFile;
        });
      }
    }
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.enabled,
    this.width,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final String value;
  final bool enabled;
  final double? width;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 60.w),
        height: 90.sp,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18.w,
                  color: Theme.of(context).textTheme.headline3!.color,
                ),
                SizedBox(width: 10.w),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.headline3!.color,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 28.w),
                Expanded(
                  child: CustomTextFormField(
                    initialValue: value,
                    enabled: enabled,
                    width: width,
                    validator: validator,
                    onSaved: onSaved,
                    textInputAction: TextInputAction.next,
                    contentPadding: EdgeInsets.fromLTRB(0, 15.sp, 0, 8.sp),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class DropDownGender extends StatelessWidget {
  const DropDownGender({
    Key? key,
    required this.icon,
    required this.label,
    required this.groupValue,
    required this.enabled,
    required this.onChanged,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final String? groupValue;
  final bool enabled;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 60.w),
        height: 90.sp,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18.w,
                  color: Theme.of(context).textTheme.headline3!.color,
                ),
                SizedBox(width: 10.w),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.headline3!.color,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 16.w),
                CustomRadioButton(
                  text: AppLocalizations.of(context)!.male,
                  value: 'male',
                  groupValue: groupValue,
                  enabled: enabled,
                  onChanged: onChanged,
                ),
                SizedBox(width: 40.w),
                CustomRadioButton(
                  text: AppLocalizations.of(context)!.female,
                  value: 'female',
                  groupValue: groupValue,
                  enabled: enabled,
                  onChanged: onChanged,
                ),
              ],
            ),
          ],
        ));
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:padel/src/widgets/widget_models/custom_textformfield.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  bool isEditing = false;

  Future imagePicker() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final selectedImage = File(image.path);
      setState(() => this.image = selectedImage);
    } on PlatformException catch (e) {
      print('Fieled to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            color: Theme.of(context).textTheme.headline1!.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 70.h),
          Container(
            height: 120.sp,
            width: 120.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 3),
            ),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).textTheme.headline5!.color,
                // backgroundImage: FileImage(image!),
              ),
            ),
          ),
          SizedBox(height: 70.h),
          info(context, Icons.badge_outlined, 'Full Name',
              'Salah Eddine Messaoudi'),
          info(context, Icons.call_outlined, 'Phone Number', '+965 2871 2942'),
          info(context, Icons.male, 'Gender', 'Male'),
          info(context, Icons.person_outline_rounded, 'Age', 23.toString()),
        ],
      ),
      floatingActionButton: Container(
        width: 150.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.sp),
          color: Theme.of(context).primaryColor,
        ),
        child: RawMaterialButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Edit Profile',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              SizedBox(width: 10.w),
              Icon(
                Icons.edit_outlined,
                size: 20.sp,
                color: Theme.of(context).scaffoldBackgroundColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding info(
      BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 45.w),
          Icon(
            icon,
            size: 18.sp,
            color: Theme.of(context).textTheme.headline3!.color,
          ),
          SizedBox(width: 5.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  height: 1.7,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.headline3!.color,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

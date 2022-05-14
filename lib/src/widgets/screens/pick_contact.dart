import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/widgets/tiles.dart';
import 'package:padel/src/widgets/widget_models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

class PickContact extends StatefulWidget {
  const PickContact({
    Key? key,
    required this.onPick,
  }) : super(key: key);

  final void Function(String) onPick;

  @override
  State<PickContact> createState() => _PickContactState();
}

class _PickContactState extends State<PickContact> {
  TextEditingController controller = TextEditingController();
  List<Contact>? listContacts;
  List<Contact>? searchContacts;

  Future<void> getContacts(BuildContext context) async {
    if (listContacts != null && searchContacts != null) return;
    late PermissionStatus serviceStatus;
    serviceStatus = await Permission.contacts.status;
    if (serviceStatus.isPermanentlyDenied) {
      dontHavePermission(context);
    }
    if (!serviceStatus.isGranted) {
      await Permission.contacts.request();
      serviceStatus = await Permission.contacts.status;
      if (!serviceStatus.isGranted) {
        dontHavePermission(context);
      }
    }
    listContacts = await FlutterContacts.getContacts(
      withProperties: true,
      withPhoto: true,
    );
    searchContacts = [];
    searchContacts!.addAll(listContacts!);
  }

  void dontHavePermission(BuildContext context) {
    Navigator.pop(context);
    showOneButtonDialog(
      context: context,
      title: 'Need access to your contacts',
      content:
          'Give Padel Life permission to access your contacts list in order to activate this feature.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: getContacts(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            dontHavePermission(context);
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              height: 0.9.sh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5.sp, bottom: 10.sp),
                    width: 120.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.headline2!.color!,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: CustomTextFormField(
                      suffixIcon: Icons.close,
                      suffixOnTap: () {
                        controller.text = '';
                      },
                      controller: controller,
                      prefixIcon: Icons.search,
                      style: GoogleFonts.poppins(
                        height: 1,
                        color: Theme.of(context).textTheme.headline1!.color,
                        fontSize: 16.sp,
                      ),
                      onChanged: (value) => search(value ?? ''),
                      keyboardType: TextInputType.name,
                      contentPadding: EdgeInsets.symmetric(vertical: 16.sp),
                      fontSize: 16,
                      onEditingComplete: () => search(controller.text),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    AppLocalizations.of(context)!.add_new_friend,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.select_contact,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.headline4!.color,
                    ),
                  ),
                  searchContacts == null
                      ? const LoadingTile()
                      : searchContacts!.isEmpty
                          ? EmptyListView(
                              text: AppLocalizations.of(context)!
                                  .empty_friends_myfriends,
                              topPadding: 50.h,
                            )
                          : Expanded(
                              child: ListView.separated(
                                itemCount: searchContacts!.length,
                                padding: EdgeInsets.only(top: 10.h),
                                itemBuilder: (context, index) => ContactTile(
                                  contact: searchContacts![index],
                                  onPick: widget.onPick,
                                ),
                                separatorBuilder: (context, _) =>
                                    const CustomSeperator(),
                              ),
                            ),
                ],
              ),
            ),
          );
        });
  }

  void search(String value) {
    searchContacts!.clear();
    if (value.isEmpty) {
      searchContacts!.addAll(listContacts!);
    } else {
      searchContacts!.addAll(listContacts!
          .where((element) =>
              element.displayName.toLowerCase().contains(value) ||
              (element.phones.isNotEmpty &&
                  element.phones.first.number.contains(value)))
          .toList());
    }
    setState(() {});
  }
}

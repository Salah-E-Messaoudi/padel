import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:padel/functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/widgets/tiles.dart';
import 'package:padel/src/widgets/widget_models.dart';

class MyFriends extends StatefulWidget {
  const MyFriends({
    Key? key,
    required this.user,
    this.booking,
  }) : super(key: key);

  final UserData user;
  final Booking? booking;

  @override
  State<MyFriends> createState() => _MyFriendsState();
}

class _MyFriendsState extends State<MyFriends> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (!ListFriends.canGetMore || ListFriends.isLoading) return;
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (mounted) setState(() {});
        ListFriends.getMore().then((_) {
          if (mounted) setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ListFriends.get(),
        builder: (context, _) {
          return Scaffold(
            body: RefreshIndicator(
              backgroundColor: const Color.fromARGB(245, 245, 245, 255),
              color: Theme.of(context).primaryColor,
              onRefresh: onRefresh,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScroled) => [
                  CustomSliverAppBar(
                    title: widget.booking != null
                        ? AppLocalizations.of(context)!.invite_friends
                        : AppLocalizations.of(context)!.my_friends,
                    actions: widget.booking != null
                        ? null
                        : [
                            IconButton(
                              onPressed: () => showModalBottomSheet(
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
                                builder: (context) => const AddFriend(),
                              ),
                              icon: Icon(
                                Icons.add_rounded,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                                size: 26.sp,
                              ),
                            ),
                          ],
                  ),
                ],
                body: ListFriends.isNull
                    ? const LoadingTile()
                    : ListFriends.isEmpty
                        ? EmptyListView(
                            text: widget.booking != null
                                ? AppLocalizations.of(context)!
                                    .empty_friends_invite
                                : AppLocalizations.of(context)!
                                    .empty_friends_myfriends,
                            topPadding: 350.h,
                          )
                        : RefreshIndicator(
                            backgroundColor:
                                const Color.fromARGB(245, 245, 245, 255),
                            color: Theme.of(context).primaryColor,
                            onRefresh: onRefresh,
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: ListFriends.list.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) => MyFriendsTile(
                                friend: ListFriends.list[index],
                                booking: widget.booking,
                              ),
                            ),
                          ),
              ),
            ),
          );
        });
  }

  Future<void> onRefresh() async {
    await ListFriends.refresh();
    setState(() {});
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
              if (_keyA.currentState!.validate()) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10.h),
                          Icon(
                            Icons.task_alt_rounded,
                            size: 70.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'Success!',
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'You have successfuly add new friend, now you can invite him to your matches',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).textTheme.headline4!.color,
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        Center(
                          child: ElevatedButton(
                            child: Text(
                              'Ok',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
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
  }
}

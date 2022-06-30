import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/widgets/screens.dart';
import 'package:padel/src/widgets/tiles.dart';
import 'package:padel/src/widgets/widget_models.dart';
import 'package:share_plus/share_plus.dart';

class MyFriends extends StatefulWidget {
  const MyFriends({
    Key? key,
    required this.user,
    this.booking,
  }) : super(key: key);

  final UserData user;
  final BookingMax? booking;

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
            floatingActionButton: FloatingActionButton(
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
                builder: (context) => AddFriend(
                  user: widget.user,
                  rebuildScreen: () => onRefresh(),
                ),
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 26.sp,
              ),
            ),
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
                    actions: [
                      IconButton(
                        onPressed: () => Share.share(
                          AppLocalizations.of(context)!.alert_share_invitation,
                          subject: 'Download and join Padel Park now',
                        ),
                        icon: Icon(
                          Icons.share,
                          color: Theme.of(context).textTheme.headline1!.color,
                          size: 24.sp,
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
                            child: ListView.separated(
                              controller: scrollController,
                              itemCount: ListFriends.list.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) => MyFriendsTile(
                                friend: ListFriends.list[index],
                                booking: widget.booking,
                              ),
                              separatorBuilder: (context, _) =>
                                  const CustomSeperator(),
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

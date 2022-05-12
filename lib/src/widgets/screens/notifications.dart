import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/widgets/screens.dart';
import 'package:padel/src/widgets/tiles.dart';
import 'package:padel/src/widgets/widget_models.dart';

class Notifications extends StatefulWidget {
  const Notifications({
    Key? key,
    required this.user,
    required this.changeTab,
  }) : super(key: key);

  final UserData user;
  final void Function(int) changeTab;

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (!ListNotifications.canGetMore || ListNotifications.isLoading) return;
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (mounted) setState(() {});
        ListNotifications.getMore().then((_) {
          if (mounted) setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ListNotifications.get(),
        builder: (context, _) {
          return Scaffold(
            body: RefreshIndicator(
              backgroundColor: const Color.fromARGB(245, 245, 245, 255),
              color: Theme.of(context).primaryColor,
              onRefresh: onRefresh,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScroled) => [
                  CustomSliverAppBar(
                    title: AppLocalizations.of(context)!.notifications,
                    actions: [
                      IconButton(
                        onPressed: () {
                          showFutureAlertDialog(
                            context: context,
                            title: AppLocalizations.of(context)!
                                .alert_delete_all_notifications_title,
                            content: AppLocalizations.of(context)!
                                .alert_delete_all_notifications_subtitle,
                            onYes: () async {
                              await ListNotifications.deleteAllFromDb();
                            },
                            onComplete: () {
                              setState(() {});
                            },
                            onException: (e) {
                              showSnackBarMessage(
                                context: context,
                                hintMessage:
                                    AppLocalizations.of(context)!.unknown_error,
                                icon: Icons.info_outline,
                              );
                              ListNotifications.refresh()
                                  .then((_) => setState(() {}));
                            },
                          );
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: Theme.of(context).textTheme.headline1!.color,
                          size: 26.sp,
                        ),
                      ),
                    ],
                  ),
                ],
                body: ListNotifications.isNull
                    ? const LoadingTile()
                    : ListNotifications.isEmpty
                        ? EmptyListView(
                            text: AppLocalizations.of(context)!
                                .empty_notifications,
                            topPadding: 350.h,
                          )
                        : RefreshIndicator(
                            backgroundColor:
                                const Color.fromARGB(245, 245, 245, 255),
                            color: Theme.of(context).primaryColor,
                            onRefresh: onRefresh,
                            child: ListView.separated(
                              controller: scrollController,
                              itemCount: ListNotifications.list.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) => NotificationTile(
                                notification: ListNotifications.list[index],
                                onTap: onClickNotification,
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
    await ListNotifications.refresh();
    setState(() {});
  }

  Future<void> onClickNotification(FBNotification notification) async {
    notification.markAsSeen();
    try {
      switch (notification.key) {
        case 'friend_added_1':
        case 'friend_added_2':
        case 'friend_added_3':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyFriends(
                user: widget.user,
              ),
            ),
          );
          break;
        case 'new_invitation':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PendingInvitations(
                user: widget.user,
              ),
            ),
          );
          break;
        case 'invitation_accepted':
          Navigator.pop(context);
          widget.changeTab(1);
          break;
        default:
      }
    } on Exception {
      notification.reference.delete();
    }
  }
}

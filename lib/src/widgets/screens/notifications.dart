import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/widgets/tiles.dart';
import 'package:padel/src/widgets/widget_models.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

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
                            title: 'Delete',
                            content:
                                'Are you sure you want to delete all your notifications',
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
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: ListNotifications.list.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) => NotificationTile(
                                notification: ListNotifications.list[index],
                              ),
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
    showLoadingWidget(context);

    try {
      String id = notification.id;
      switch (notification.key) {
        case 'new_order':
          break;
        case 'order_completed':
        case 'order_canceled':
        case 'order_review':
          break;
        default:
          Navigator.pop(context);
      }
    } on Exception {
      Navigator.pop(context);
      notification.reference.delete();
    }
  }
}

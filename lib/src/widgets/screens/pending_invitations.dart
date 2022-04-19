import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:padel/src/services_models/list_models.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/widgets/tiles.dart';
import 'package:padel/src/widgets/widget_models.dart';

class PendingInvitations extends StatefulWidget {
  const PendingInvitations({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  State<PendingInvitations> createState() => _PendingInvitationsState();
}

class _PendingInvitationsState extends State<PendingInvitations> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (!ListPendingInvitations.canGetMore ||
          ListPendingInvitations.isLoading) return;
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (mounted) setState(() {});
        ListPendingInvitations.getMore().then((_) {
          if (mounted) setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ListPendingInvitations.get(),
        builder: (context, _) {
          return Scaffold(
            body: RefreshIndicator(
              backgroundColor: const Color.fromARGB(245, 245, 245, 255),
              color: Theme.of(context).primaryColor,
              onRefresh: onRefresh,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScroled) => [
                  CustomSliverAppBar(
                    title: AppLocalizations.of(context)!.pending_invitation,
                    actions: null,
                  ),
                ],
                body: ListPendingInvitations.isNull
                    ? const LoadingTile()
                    : ListPendingInvitations.isEmpty
                        ? EmptyListView(
                            text: AppLocalizations.of(context)!
                                .empty_pending_invitations,
                            topPadding: 350.h,
                          )
                        : RefreshIndicator(
                            backgroundColor:
                                const Color.fromARGB(245, 245, 245, 255),
                            color: Theme.of(context).primaryColor,
                            onRefresh: onRefresh,
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: ListPendingInvitations.list.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) =>
                                  PendingInvitationTile(
                                user: widget.user,
                                invitation: ListPendingInvitations.list[index],
                                popInvitation: (invitation) =>
                                    deleteInvitation(invitation),
                              ),
                            ),
                          ),
              ),
            ),
          );
        });
  }

  Future<void> onRefresh() async {
    await ListPendingInvitations.refresh();
    setState(() {});
  }

  void deleteInvitation(PendingInvitation invitation) {
    setState(() {
      ListPendingInvitations.deleteFromList(invitation);
    });
  }
}

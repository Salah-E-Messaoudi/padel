import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:padel/src/widgets/tiles.dart';
import 'package:padel/src/widgets/widget_models.dart';

class PendingInvitation extends StatelessWidget {
  const PendingInvitation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AppBarTitle(
          title: AppLocalizations.of(context)!.pending_invitation,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: const [PendingInvitationTile()],
      ),
    );
  }
}

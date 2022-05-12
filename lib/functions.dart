// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/widgets/tiles.dart';

String? getError(BuildContext context, String? code) {
  if (code == null) {
    return null;
  }
  switch (code) {
    case 'account-exists-with-different-credential':
      return 'Sign in using a provider associated with this email.';
    case 'credential-already-in-use':
      return AppLocalizations.of(context)!.credential_already_in_use;
    case 'invalid-continue-uri':
      return AppLocalizations.of(context)!.invalid_continue_uri;
    case 'invalid-credential':
      return AppLocalizations.of(context)!.invalid_credential;
    case 'invalid-phone-number':
      return AppLocalizations.of(context)!.invalid_phone_number;
    case 'invalid-verification-code':
      return AppLocalizations.of(context)!.invalid_verification_code;
    case 'invalid-verification-id':
      return AppLocalizations.of(context)!.invalid_verification_id;
    case 'missing-android-pkg-name':
      return AppLocalizations.of(context)!.missing_android_pkg_name;
    case 'missing-client-identifier':
      return AppLocalizations.of(context)!.missing_client_identifier;
    case 'missing-continue-uri':
      return AppLocalizations.of(context)!.missing_continue_uri;
    case 'missing-ios-bundle-id':
      return AppLocalizations.of(context)!.missing_ios_bundle_id;
    case 'network-request-failed':
      return AppLocalizations.of(context)!.network_request_failed;
    case 'operation-not-allowed':
      return AppLocalizations.of(context)!.operation_not_allowed;
    case 'provider-already-linked':
      return AppLocalizations.of(context)!.provider_already_linked;
    case 'quota-exceeded':
      return AppLocalizations.of(context)!.quota_exceeded;
    case 'requires-recent-login':
      return AppLocalizations.of(context)!.requires_recent_login;
    case 'too-many-requests':
      return AppLocalizations.of(context)!.too_many_requests;
    case 'unauthorized-continue-uri':
      return AppLocalizations.of(context)!.unauthorized_continue_uri;
    case 'user-disabled':
      return AppLocalizations.of(context)!.user_disabled;
    case 'user-mismatch':
      return AppLocalizations.of(context)!.user_mismatch;
    case 'user-not-found':
      return AppLocalizations.of(context)!.user_not_found;
    case 'app-not-authorized':
      return AppLocalizations.of(context)!.app_not_authorized;
    case 'invalid-body':
    case 'invalid-owner-data':
      return AppLocalizations.of(context)!.invalid_request;
    case 'already-friends':
      return AppLocalizations.of(context)!.already_friends;
    default:
      return code;
  }
}

String? validateNumberInt(
    {required String? value, required BuildContext context}) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.field_required;
  }
  if (int.tryParse(value) == null) {
    return AppLocalizations.of(context)!.invalid_phone_number;
  }
  return null;
}

String? validateNotNull({
  required String? value,
  required BuildContext context,
}) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.field_required;
  }
  return null;
}

String? validatePhone({
  required String? value,
  required BuildContext context,
}) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(pattern);
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.field_required;
  } else if (!regExp.hasMatch(value)) {
    return AppLocalizations.of(context)!.invalid_phone_number;
  } else {
    return null;
  }
}

void showSnackBarMessage({
  required BuildContext context,
  required String hintMessage,
  int seconds = 2,
  IconData icon = Icons.check_outlined,
  double fontSize = 16,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: seconds),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 22.sp),
          SizedBox(
            width: 15.w,
          ),
          Text(hintMessage,
              style: GoogleFonts.openSans(
                fontSize: fontSize.sp,
                color: Colors.white,
              )),
        ],
      )));
}

void showOneButtonDialog({
  required BuildContext context,
  required String title,
  required String content,
}) {
  showDialog(
    context: context,
    builder: Platform.isIOS
        ? (context) => CupertinoAlertDialog(
              title: Text(
                title,
              ),
              content: Text(
                content,
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(AppLocalizations.of(context)!.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
        : (context) => AlertDialog(
              title: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Text(
                content,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(AppLocalizations.of(context)!.close),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
  );
}

void showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? yesLabel,
  String? noLabel,
  required Future<void> Function() onYes,
}) {
  showDialog(
    context: context,
    builder: Platform.isIOS
        ? (context) => CupertinoAlertDialog(
              title: Text(
                title,
              ),
              content: Text(
                content,
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(noLabel ?? AppLocalizations.of(context)!.cancel),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                CupertinoDialogAction(
                  child: Text(yesLabel ?? AppLocalizations.of(context)!.yes),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onYes();
                  },
                ),
              ],
            )
        : (context) => AlertDialog(
              title: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Text(
                content,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(noLabel ?? AppLocalizations.of(context)!.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(yesLabel ?? AppLocalizations.of(context)!.yes),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await onYes();
                  },
                ),
              ],
            ),
  );
}

void showFutureAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? yesLabel,
  String? noLabel,
  required Future<void> Function() onYes,
  void Function()? onComplete,
  void Function(Exception)? onException,
}) {
  showAlertDialog(
    context: context,
    title: title,
    content: content,
    yesLabel: yesLabel,
    noLabel: noLabel,
    onYes: () async {
      showLoadingWidget(context);
      try {
        await onYes().then((_) {
          Navigator.pop(context);
          if (onComplete != null) {
            onComplete();
          }
        });
      } on Exception catch (e) {
        Navigator.pop(context);
        if (onException != null) {
          onException(e);
        }
      }
    },
  );
}

void showLoadingWidget(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => WillPopScope(
      onWillPop: () async => Future.value(false),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: const [LoadingTile()],
      ),
    ),
  );
}

DateTime? getDateTime(dynamic value, [bool init = true]) {
  if (value == null && !init) return null;
  if (value == null) return DateTime.now();
  if (value is Timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(value.millisecondsSinceEpoch)
        .toLocal();
  } else if (value is int) {
    return DateTime.fromMillisecondsSinceEpoch(value).toLocal();
  } else {
    return DateTime.parse(value);
  }
}

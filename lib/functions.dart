// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    default:
      return code;
  }
}

String? validateNumberInt(
    {required String? value, required BuildContext context}) {
  if (value == null || value.isEmpty) {
    return 'AppLocalizations.of(context)!.field_required';
  }
  if (int.tryParse(value) == null) {
    return 'AppLocalizations.of(context)!.value_invalid';
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

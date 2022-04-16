import 'package:flutter/material.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/settings/preferences.dart';
import 'package:padel/src/settings/settings_controller.dart';
import 'package:padel/src/widgets/authentication.dart';
import 'package:padel/src/widgets/screens.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({
    Key? key,
    required this.settingsController,
  }) : super(key: key);
  final SettingsController settingsController;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool? showOnboarding;
  UserData? userStream;

  @override
  Widget build(BuildContext context) {
    userStream = Provider.of<UserData?>(context);
    if (userStream != null && userStream!.init) {
      return const SplashScreen(loading: true);
    }
    return FutureBuilder(
        future: getShowOnboarding(),
        builder: (context, snapshot) {
          if (showOnboarding == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen(loading: true);
          }
          if (showOnboarding == true) {
            return Onboarding(setShowOnboarding: hideOnboarding);
          } else {
            if (userStream == null) {
              return const PhoneAuth();
            } else {
              if (userStream!.isNotComplete) {
                return SetupAccount(
                  user: userStream!,
                  rebuildWrapper: () => setState(() {}),
                );
              } else {
                return MainScreen(user: userStream!);
              }
            }
          }
        });
  }

  Future<void> getShowOnboarding() async {
    showOnboarding = showOnboarding ?? await Preferences().getShowOnboarding();
  }

  void hideOnboarding() {
    setState(() {
      showOnboarding = false;
    });
    Preferences().setShowOnboarding(false);
  }
}

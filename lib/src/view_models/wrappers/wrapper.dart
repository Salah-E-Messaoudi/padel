import 'package:flutter/material.dart';
import 'package:padel/src/settings/preferences.dart';
import 'package:padel/src/settings/settings_controller.dart';
import 'package:padel/src/widgets/authentication.dart';

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
  // UserData? userStream;

  @override
  Widget build(BuildContext context) {
    // userStream = Provider.of<UserData?>(context);
    // if (userStream != null &&
    //     (userStream == UserData() || userStream!.uid == null)) {
    //   return const SplashScreen(
    //     loading: true,
    //   );
    // }
    return FutureBuilder(
        future: getShowOnboarding(),
        builder: (context, snapshot) {
          // if (showOnboarding == null ||
          //     snapshot.connectionState == ConnectionState.waiting) {
          //   return const SplashScreen(
          //     loading: true,
          //   );
          // }
          if (showOnboarding == true) {
            return Onboarding(
              setShowOnboarding: hideOnboarding,
            );
          } else {
            return Container(color: Colors.white);
          }
          // if (userStream == null) {
          //   return PhoneAuth();
          // } else {
          //   if (userStream!.requiresCompleteRegistration) {
          //     return CompleteRegisration(
          //       user: userStream!,
          //       rebuildWrapper: () {
          //         setState(() {});
          //       },
          //     );
          //   } else {
          //     if (userStream!.approved != true) {
          //       return PendingApproval(
          //         user: userStream!,
          //       );
          //     } else {
          //       return MainScreen(
          //         user: userStream!,
          //       );
          //     }
          //   }
          // }
        });
  }

  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 1));
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

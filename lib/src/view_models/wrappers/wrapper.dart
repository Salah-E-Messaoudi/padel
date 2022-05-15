import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:padel/main.dart';
import 'package:padel/src/app.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';
import 'package:padel/src/settings/preferences.dart';
import 'package:padel/src/settings/settings_controller.dart';
import 'package:padel/src/widgets/authentication.dart';
import 'package:padel/src/widgets/screens.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({
    Key? key,
    required this.settingsController,
    required this.locale,
  }) : super(key: key);

  final SettingsController settingsController;
  final Locale? locale;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool? showOnboarding;
  UserData? userStream;
  Locale? locale;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    log(widget.locale?.languageCode ?? 'null');
    locale = widget.locale;
    initializeDateFormatting(locale?.languageCode);
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message == null) return;
      log('getInitialMessage called');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      if (!kIsWeb) {
        log('onMessage.listen called');
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: '@mipmap/ic_launcher',
                channelShowBadge: true,
                importance: Importance.max,
                playSound: true,
                priority: Priority.max,
                visibility: NotificationVisibility.public,
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Notifications(
            user: userStream!,
            changeTab: (index) {},
          ),
        ),
      );
    });
  }

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
          if (locale == null) {
            return PickLanguage(
              setLocale: (locale) {
                Preferences().setLocale(locale);
                MyApp.setLocale(context, locale);
              },
            );
          }
          return FutureBuilder<bool>(
              future: RemoteConfigService.setup(context),
              builder: (context, configSnapshot) {
                if (!configSnapshot.hasData) {
                  return const SplashScreen(loading: true);
                }
                if (configSnapshot.data == true) {
                  return SplashScreen(
                    loading: true,
                    topPadding: 200.h,
                  );
                }
                if (showOnboarding == true) {
                  return Onboarding(setShowOnboarding: hideOnboarding);
                } else {
                  if (userStream == null) {
                    return PhoneAuth(
                      rebuildWrapper: () => setState(() {}),
                    );
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
        });
  }

  Future<void> getShowOnboarding() async {
    if (locale == null) {
      locale = await Preferences().getLocale();
      if (locale != widget.locale) {
        MyApp.setLocale(context, locale!);
      }
    }
    showOnboarding = showOnboarding ?? await Preferences().getShowOnboarding();
  }

  void hideOnboarding() {
    setState(() {
      showOnboarding = false;
    });
    Preferences().setShowOnboarding(false);
  }
}

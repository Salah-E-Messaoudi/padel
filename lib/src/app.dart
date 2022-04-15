import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:padel/src/view_models/wrappers/wrapper.dart';
// import 'package:provider/provider.dart';
import 'settings/settings_controller.dart';
// import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392.7, 834.9),
        builder: () => AnimatedBuilder(
              animation: settingsController,
              builder: (BuildContext context, Widget? child) {
                return MaterialApp(
                  restorationScopeId: 'app',
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    CountryLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', ''), // English, no country code
                    // Locale('fr', ''), // French, no country code
                    Locale('ar', ''), // Arabic, no country code
                  ],
                  onGenerateTitle: (BuildContext context) =>
                      AppLocalizations.of(context)!.appTitle,
                  theme: ThemeData().copyWith(
                    primaryColor: const Color(0xFF3F4170),
                    scaffoldBackgroundColor: Colors.white,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    buttonTheme: const ButtonThemeData(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: const Color(0xFF3F4170),
                      selectionColor: const Color(0xFF3F4170).withOpacity(0.2),
                      selectionHandleColor: const Color(0xFF3F4170),
                    ),
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.white,
                      titleTextStyle: TextStyle(color: Color(0xFF000000)),
                      actionsIconTheme: IconThemeData(color: Color(0xFF000000)),
                      iconTheme: IconThemeData(
                        color: Color(0xFF000000),
                      ),
                    ),
                    textTheme: ThemeData.light().textTheme.copyWith(
                          headline1: const TextStyle(color: Color(0xFF000000)),
                          headline2: const TextStyle(color: Color(0xFF4A4A4A)),
                          headline3: const TextStyle(color: Color(0xFF8F8F8F)),
                          headline4: const TextStyle(color: Color(0xFFBBBBBB)),
                          headline5: const TextStyle(color: Color(0xFFECECEC)),
                          headline6: const TextStyle(color: Color(0xFFA2CA30)),
                        ),
                  ),
                  home: Wrapper(
                    settingsController: settingsController,
                  ),
                );
              },
            ));
  }
}

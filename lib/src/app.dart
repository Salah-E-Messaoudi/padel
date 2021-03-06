import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';
import 'package:padel/src/view_models/wrappers.dart';
import 'package:provider/provider.dart';
import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    if (state != null) state.setLocal(locale);
  }

  static Locale? getLocale(BuildContext context) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    if (state != null) return state.locale;
    return null;
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  Locale? get locale {
    return _locale;
  }

  void setLocal(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392.7, 834.9),
        builder: () => AnimatedBuilder(
              animation: widget.settingsController,
              builder: (BuildContext context, Widget? child) {
                return MultiProvider(
                  providers: [
                    StreamProvider<UserData?>.value(
                      value: AuthenticationService.userStream,
                      initialData: UserData(init: true),
                    ),
                  ],
                  child: MaterialApp(
                    restorationScopeId: 'app',
                    debugShowCheckedModeBanner: false,
                    locale: _locale,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      CountryLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en', ''), // English, no country code
                      Locale('ar', ''), // Arabic, no country code
                    ],
                    onGenerateTitle: (BuildContext context) =>
                        AppLocalizations.of(context)!.appTitle,
                    theme: ThemeData().copyWith(
                      primaryColor: const Color(0xFF3F4170),
                      colorScheme: ThemeData.light().colorScheme.copyWith(
                            secondary: const Color(0xFF27B594),
                          ),
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
                        selectionColor:
                            const Color(0xFF3F4170).withOpacity(0.2),
                        selectionHandleColor: const Color(0xFF3F4170),
                      ),
                      appBarTheme: const AppBarTheme(
                        backgroundColor: Colors.white,
                        titleTextStyle: TextStyle(color: Color(0xFF000000)),
                        actionsIconTheme:
                            IconThemeData(color: Color(0xFF000000)),
                        iconTheme: IconThemeData(
                          color: Color(0xFF000000),
                        ),
                      ),
                      textTheme: ThemeData.light().textTheme.copyWith(
                            headline1:
                                const TextStyle(color: Color(0xFF000000)),
                            headline2:
                                const TextStyle(color: Color(0xFF4A4A4A)),
                            headline3:
                                const TextStyle(color: Color(0xFF8F8F8F)),
                            headline4:
                                const TextStyle(color: Color(0xFFBBBBBB)),
                            headline5:
                                const TextStyle(color: Color(0xFFECECEC)),
                            headline6:
                                const TextStyle(color: Color(0xFFA2CA30)),
                          ),
                    ),
                    home: Wrapper(
                      locale: locale,
                      settingsController: widget.settingsController,
                    ),
                  ),
                );
              },
            ));
  }
}

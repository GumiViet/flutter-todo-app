import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_to_do/resources/constants.dart';
import 'package:flutter_to_do/main.route.dart';
import 'package:flutter_to_do/resources/localization/app_translations_delegate.dart';
import 'package:flutter_to_do/resources/localization/application.dart';
import 'package:flutter_to_do/resources/styles.dart';
import 'package:flutter_to_do/screen/splash/splash_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:route_annotation/route_annotation.dart';

import 'dependency_injection/dependency_injection.dart';

void main() async => {
      initInject(),
      await initLangCode(),
      Provider.debugCheckInvalidValueType = null,
      runApp(MyApp()),
    };

@router
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;
  Key myKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _newLocaleDelegate =
        AppTranslationsDelegate(newLocale: Locale("jp", "Japan"));
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppStyles.mainTheme,
          key: myKey,
          navigatorKey: application.getNavigatorKey(isGenNewKey: true),
          initialRoute: AppConstants.ROUTE_SPLASH,
          onGenerateRoute: generateRoute,
          localizationsDelegates: [
            _newLocaleDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale("jp", ""),
            const Locale("en", ""),
          ]),
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}

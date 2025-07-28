import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/services.dart';
import 'shared_pref_util/shared_pref_util.dart';
import 'constant/colors.dart';
import 'constant/dimensions.dart';
import 'firebase_options.dart';
import 'screens/splashScreen/splash_screen.dart';
import 'customWidget/networkConnectivityChecker/internet_service.dart';

late AppLocalizations languages;
Locale? selectedLocale;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InternetService().startMonitoring();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initPreferences();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // Choose your desired color
      statusBarIconBrightness: Brightness.dark,
      // Or Brightness.dark for dark icons
      statusBarBrightness: Brightness.light,
      // Optionally, set navigation bar color as well
      systemNavigationBarColor: colorWhite,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    /// Flutter doesn't give you direct access to a widget's state unless:
    /// You pass it down manually (inconvenient for deep trees)
    var state = context.findAncestorStateOfType<MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  //For Multi Language
  void setLocale(Locale locale) {
    setState(() {
      selectedLocale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    selectedLocale = getLocale();
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        InternetService().startMonitoring();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        InternetService().dispose();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    InternetService().dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: colorWhite,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      builder: (context, child) {
        if (AppLocalizations.of(context) != null) {
          languages = AppLocalizations.of(context)!;
        }
        deviceHeight = MediaQuery.of(context).size.height;
        deviceWidth = MediaQuery.of(context).size.width;
        deviceAvgScreenSize = (deviceHeight + deviceWidth) / 2;
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(0.9)),
          // child: child ?? Container(),
          child: ScrollConfiguration(behavior: MyBehavior(), child: child ?? Container()),
        );
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        textTheme: GoogleFonts.leagueSpartanTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary),
        useMaterial3: true,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      locale: selectedLocale,
      home: const SplashScreen(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

import 'package:evently_c20_online/core/app_provider/app_provider.dart';
import 'package:evently_c20_online/core/theme/app_theme.dart';
import 'package:evently_c20_online/modules/auth/screens/forget_password_screen.dart';
import 'package:evently_c20_online/modules/auth/screens/login_screen.dart';
import 'package:evently_c20_online/modules/auth/screens/resgister_screen.dart';
import 'package:evently_c20_online/modules/onboarding/screens/onboarding_screen.dart';
import 'package:evently_c20_online/modules/splash/screens/splash_screen.dart';
import 'package:evently_c20_online/modules/start/screens/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'modules/add_event/screens/add_event_screen.dart';
import 'modules/layout/screens/layout_screen.dart';

import 'package:evently_c20_online/modules/event_details/screens/event_details_screen.dart';
import 'package:evently_c20_online/modules/edit_event/screens/edit_event_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await GoogleSignIn.instance.initialize(
    serverClientId: "1090284136673-57k6khn56v4ljiofbdnkpg7e9vniju6p.apps.googleusercontent.com",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      builder: (context, child) {
        var provider = Provider.of<AppProvider>(context);
        return MaterialApp(
          routes: {
            SplashScreen.routeName : (_) => SplashScreen(),
            StartScreen.routeName : (_) => StartScreen(),
            OnboardingScreen.routeName : (_) => OnboardingScreen(),
            LoginScreen.routeName : (_) => LoginScreen(),
            RegisterScreen.routeName : (_) => RegisterScreen(),
            ForgetPasswordScreen.routeName : (_) => ForgetPasswordScreen(),
            LayoutScreen.routeName : (_) => LayoutScreen(),
            AddEventScreen.routeName : (_) => AddEventScreen(),
            EventDetailsScreen.routeName : (_) => EventDetailsScreen(),
            EditEventScreen.routeName : (_) => EditEventScreen(),
          },
          initialRoute:SplashScreen.routeName,
          locale: Locale(provider.locale),
          localizationsDelegates: [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],          supportedLocales: [
          Locale('en'),
          Locale('ar'),
        ],
          themeMode: provider.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          title: 'Flutter Demo',
        );
      },
    );
  }
}
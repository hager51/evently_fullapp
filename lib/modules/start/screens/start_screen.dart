import 'package:evently_c20_online/core/app_provider/app_provider.dart';
import 'package:evently_c20_online/l10n/app_localizations.dart';
import 'package:evently_c20_online/modules/onboarding/screens/onboarding_screen.dart';
import 'package:evently_c20_online/modules/start/widgets/selected_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = "startScreen";
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    var local = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "logo",
                child: Center(
                  child: Image.asset(
                    "assets/logo/app_logo.png",
                    width: 140,
                    color: theme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Image.asset(
                  "assets/images/being-creative.png",
                  color: theme.primaryColorLight,
                ),
              ),
              const SizedBox(height: 24),
              Text(local.titleStart, style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(local.desStart, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      local.language,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SelectedWidget(
                    isSelected: provider.locale == "en",
                    onTap: () {
                      provider.changeLocale("en");
                    },
                    title: local.english,
                  ),
                  const SizedBox(width: 8),
                  SelectedWidget(
                    isSelected: provider.locale == "ar",
                    onTap: () {
                      provider.changeLocale("ar");
                    },
                    title: local.arabic,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      local.theme,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SelectedWidget.icon(
                    onTap: () {
                      provider.changeTheme(ThemeMode.light);
                    },
                    isSelected: provider.themeMode == ThemeMode.light,
                    icon: "assets/icons/sun.png",
                  ),
                  const SizedBox(width: 8),
                  SelectedWidget.icon(
                    onTap: () {
                      provider.changeTheme(ThemeMode.dark);
                    },
                    isSelected: provider.themeMode == ThemeMode.dark,
                    icon: "assets/icons/moon.png",
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, OnboardingScreen.routeName);
                  },
                  child: Center(child: Text(local.letsStart)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

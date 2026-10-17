import 'package:evently_c20_online/l10n/app_localizations.dart';
import 'package:evently_c20_online/modules/auth/screens/login_screen.dart';
import 'package:evently_c20_online/modules/onboarding/manager/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingModel {
  String title;
  String description;
  String imageName;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imageName,
  });
}

class OnboardingScreen extends StatelessWidget {
  static const String routeName = "onboarding";
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    List<OnboardingModel> pages = [
      OnboardingModel(
        title: local.onboardingTitle1,
        description: local.onboardingDesc1,
        imageName: "onboarding_1",
      ),
      OnboardingModel(
        title: local.onboardingTitle2,
        description: local.onboardingDesc2,
        imageName: "onboarding_2",
      ),
      OnboardingModel(
        title: local.onboardingTitle3,
        description: local.onboardingDesc3,
        imageName: "onboarding_3",
      ),
    ];

    return ChangeNotifierProvider(
      create: (context) => OnboardingProvider(),
      child: Consumer<OnboardingProvider>(
        builder: (context, onboardingProvider, child) {
          bool isLastPage = onboardingProvider.currentPage == pages.length - 1;

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildTopBar(context, onboardingProvider, pages.length),
                    Expanded(
                      child: PageView(
                        controller: onboardingProvider.pageController,
                        onPageChanged: onboardingProvider.onPageChanged,
                        children: buildPages(context, pages),
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isLastPage) {
                            goToLogin(context);
                          } else {
                            onboardingProvider.goToNextPage();
                          }
                        },
                        child: Center(
                          child: Text(isLastPage ? local.getStarted : local.next),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  bool checkIsDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  void goToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  // زرار الرجوع - اللوجو - زرار Skip
  Widget buildTopBar(
      BuildContext context,
      OnboardingProvider onboardingProvider,
      int pagesCount,
      ) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    bool isFirstPage = onboardingProvider.currentPage == 0;
    bool isLastPage = onboardingProvider.currentPage == pagesCount - 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 64,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: isFirstPage
                ? null
                : buildSmallButton(
              context: context,
              onTap: onboardingProvider.goToPreviousPage,
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: theme.primaryColor,
              ),
            ),
          ),
        ),
        Image.asset(
          "assets/logo/app_logo.png",
          width: 110,
          color: theme.primaryColor,
        ),
        SizedBox(
          width: 64,
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: isLastPage
                ? null
                : buildSmallButton(
              context: context,
              onTap: () {
                goToLogin(context);
              },
              child: Text(
                local.skip,
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSmallButton({
    required BuildContext context,
    required Widget child,
    required void Function() onTap,
  }) {
    var theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 32,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: theme.primaryColorDark,
          border: Border.all(color: theme.dividerColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [child]),
      ),
    );
  }

  List<Widget> buildPages(BuildContext context, List<OnboardingModel> pages) {
    List<Widget> widgets = [];
    for (int i = 0; i < pages.length; i++) {
      widgets.add(buildPage(context, pages, i));
    }
    return widgets;
  }

  Widget buildPage(
      BuildContext context,
      List<OnboardingModel> pages,
      int index,
      ) {
    var theme = Theme.of(context);
    bool isDark = checkIsDark(context);
    OnboardingModel page = pages[index];
    String imagePath =
        "assets/images/${page.imageName}_${isDark ? 'dark' : 'light'}.png";

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Center(
            child: Image.asset(
              imagePath,
              height: MediaQuery.of(context).size.height * 0.35,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 24),
          Center(child: buildDots(context, pages.length, index)),
          SizedBox(height: 24),
          Text(page.title, style: theme.textTheme.titleLarge),
          SizedBox(height: 12),
          Text(
            page.description,
            style: theme.textTheme.bodyMedium!.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget buildDots(BuildContext context, int count, int activeIndex) {
    var theme = Theme.of(context);
    bool isDark = checkIsDark(context);
    List<Widget> dots = [];

    for (int i = 0; i < count; i++) {
      bool isActive = i == activeIndex;
      dots.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? theme.primaryColor
                : (isDark ? Colors.white : Color(0xffC4C4C4)),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
    }

    return Row(mainAxisSize: MainAxisSize.min, children: dots);
  }
}
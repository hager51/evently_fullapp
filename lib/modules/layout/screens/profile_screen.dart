import 'package:evently_c20_online/core/app_provider/app_provider.dart';
import 'package:evently_c20_online/modules/auth/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 80,
                foregroundImage: AssetImage("assets/images/route.png"),
              ),
            ),
            SizedBox(height: 16),
            Text(user.displayName ?? "", style: theme.textTheme.titleLarge),
            SizedBox(height: 4),
            Text(user.email ?? "", style: theme.textTheme.bodyMedium),
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: theme.dividerColor),
                borderRadius: BorderRadius.circular(16),
                color: theme.primaryColorDark,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text("Dark mode", style: theme.textTheme.titleLarge),
                  ),
                  SizedBox(
                    height: 30,
                    child: Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        activeTrackColor: theme.primaryColor,
                        value: provider.themeMode == ThemeMode.dark,
                        onChanged: (value) {
                          provider.changeTheme(
                            value ? ThemeMode.dark : ThemeMode.light,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: theme.scaffoldBackgroundColor,
                  showDragHandle: true,
                  context: context, builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Center(child: Text("Language",style: theme.textTheme.titleMedium,),),
                        SizedBox(height: 24,),
                        GestureDetector(
                          onTap: () {
                            provider.changeLocale("ar");
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: provider.locale == "ar"?theme.primaryColor:   theme.dividerColor),
                              borderRadius: BorderRadius.circular(16),
                              color: theme.primaryColorDark,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text("Arabic", style: theme.textTheme.titleLarge),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16,),
                        GestureDetector(
                          onTap: () {
                            provider.changeLocale("en");
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: provider.locale == "en"?theme.primaryColor:   theme.dividerColor),
                              borderRadius: BorderRadius.circular(16),
                              color: theme.primaryColorDark,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text("English", style: theme.textTheme.titleLarge),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                      ],),
                  );
                },);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.dividerColor),
                  borderRadius: BorderRadius.circular(16),
                  color: theme.primaryColorDark,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("Language", style: theme.textTheme.titleLarge),
                    ),
                    SizedBox(
                      height: 30,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16,),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.dividerColor),
                  borderRadius: BorderRadius.circular(16),
                  color: theme.primaryColorDark,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("Logout", style: theme.textTheme.titleLarge),
                    ),
                    SizedBox(
                      height: 30,
                      child: Icon(Icons.logout,color: Colors.red,)
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

import 'package:evently_c20_online/modules/auth/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName = "forgetPasswordScreen";

  ForgetPasswordScreen({super.key});

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Forget Password"),
        ),
        body: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Center(child: Image.asset("assets/images/reset_password.png")),

                  SizedBox(height: 40,),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Image.asset("assets/icons/sms.png"),
                      hintText: local.emailHint,
                    ),
                  ),
                  SizedBox(height: 40,),
                  ElevatedButton(onPressed: () {
                    provider.resetPassword(email: emailController.text, context: context);
                  }, child: Center(child: Text("Reset password")))

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

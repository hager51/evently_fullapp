import 'package:evently_c20_online/l10n/app_localizations.dart';
import 'package:evently_c20_online/modules/auth/manager/auth_provider.dart';
import 'package:evently_c20_online/modules/auth/screens/login_screen.dart';
import 'package:evently_c20_online/modules/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "registerScreen";
  RegisterScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;

    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Consumer<AuthProvider>(
              builder: (context, provider, child) {
                return Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/logo/app_logo.png",
                          width: 140,
                          color: theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 48),
                      Text(
                        local.registerTitle,
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "enter name";
                          }
                        },
                        controller: nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset("assets/icons/user.png"),
                          hintText: local.nameHint,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "enter email";
                          } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value)) {
                            return "enter valid email";
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset("assets/icons/sms.png"),
                          hintText: local.emailHint,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "enter password";
                          } else if (value.length < 6) {
                            return "password must be length equal or more 6 char or number";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset("assets/icons/lock.png"),
                          hintText: local.passwordHint,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: rePasswordController,
                        validator: (value) {
                          if (value != passwordController.text) {
                            return "Password not matched";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset("assets/icons/lock.png"),
                          hintText: local.confirmPasswordHint,
                        ),
                      ),
                      const SizedBox(height: 48),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                provider.createAccount(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  context: context,
                                );
                              }
                            },
                            child: provider.isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Center(child: Text(local.signUp)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            local.alreadyHaveAccount,
                            style: theme.textTheme.bodyMedium,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                LoginScreen.routeName,
                              );
                            },
                            child: Text(
                              local.login,
                              style: theme.textTheme.titleMedium!.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: theme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

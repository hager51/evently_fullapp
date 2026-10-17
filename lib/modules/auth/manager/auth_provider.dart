import 'package:evently_c20_online/core/toast_service/toast.dart';
import 'package:evently_c20_online/modules/layout/screens/layout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isGoogleLoading = false;
  late User user;

  Future<void> createAccount({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      user = await AuthService.createAccount(
        email: email,
        password: password,
        name: name,
      );
      Toast.show(title: "Welcome $name", context: context);
    } catch (e) {
      Toast.show(title: e.toString(), context: context,type: ToastType.error);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      user = await AuthService.login(
        email: email,
        password: password,
      );

      if(user.emailVerified){
        Toast.show(title: "Welcome Back ${user.displayName}", context: context);
        Navigator.pushReplacementNamed(context, LayoutScreen.routeName);
      }else{
        await user.sendEmailVerification();
        Toast.show(title: "Pls , check your email", context: context);

      }

    } catch (e) {
      Toast.show(title: e.toString(), context: context,type: ToastType.error);
    }
    isLoading = false;
    notifyListeners();
  }

  // تسجيل الدخول بحساب جوجل
  Future<void> loginWithGoogle({required BuildContext context}) async {
    isGoogleLoading = true;
    notifyListeners();
    try {
      user = await AuthService.loginWithGoogle();

      if (!context.mounted) return;
      Toast.show(
        title: "Welcome ${user.displayName ?? user.email ?? ""}",
        context: context,
      );
      Navigator.pushReplacementNamed(context, LayoutScreen.routeName);
    } catch (e) {
      if (context.mounted) {
        Toast.show(title: e.toString(), context: context, type: ToastType.error);
      }
    }
    isGoogleLoading = false;
    notifyListeners();
  }

  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      await AuthService.resetPassword(
        email: email,
      );

      Toast.show(title: "Check your Email", context: context);
    } catch (e) {
      Toast.show(title: e.toString(), context: context,type: ToastType.error);
    }
    isLoading = false;
    notifyListeners();
  }

}
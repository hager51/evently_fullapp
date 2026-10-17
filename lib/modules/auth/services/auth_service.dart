import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static Future<User> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user?.updateProfile(displayName: name);
      await credential.user?.updateDisplayName(name);
      await credential.user?.sendEmailVerification();
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }else{
        throw e.message??"";
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw "Invalid Email or Password";
    } catch (e) {
      rethrow;
    }
  }

  // تسجيل الدخول بجوجل: بنفتح نافذة اختيار الحساب، وبعدها بنسجّل الدخول في Firebase
  static Future<User> loginWithGoogle() async {
    try {
      // 1) نافذة اختيار حساب جوجل
      final GoogleSignInAccount googleUser =
      await GoogleSignIn.instance.authenticate();

      // 2) التوكن اللي Firebase محتاجه
      final String? idToken = googleUser.authentication.idToken;

      // 3) نسجّل الدخول في Firebase بالتوكن ده
      final credential = GoogleAuthProvider.credential(idToken: idToken);
      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user!;
    } on GoogleSignInException catch (e) {
      debugPrint("Google login error: ${e.code} | ${e.description}");
      throw "Google login failed or was cancelled";
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Google login failed";
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw "Invalid Email";
    } catch (e) {
      rethrow;
    }
  }
}
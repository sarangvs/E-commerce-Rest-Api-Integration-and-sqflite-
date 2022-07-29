import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewController extends GetxController {
  bool _verificationCodeSent = false;
  String _verId = '';

  bool get verificationCodeSent => _verificationCodeSent;
  set verificationCodeSent(bool value) {
    _verificationCodeSent = value;
    update();
  }

  String get verId => _verId;
  set verId(String value) {
    _verId = value;
    update();
  }

  void verifyPhone(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        await FirebaseAuth.instance
            .signInWithCredential(phoneAuthCredential)
            .then((value) {
          Get.snackbar(
            "Login Successfull",
            "Login is completed",
            snackPosition: SnackPosition.BOTTOM,
          );
        });
      },
      verificationFailed: (FirebaseAuthException error) {
        Get.snackbar(
          "Login Failed",
          "${error.message}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationCodeSent = true;
        verId = verificationId;
        update();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verId = verificationId;
        update();
      },
      timeout: const Duration(seconds: 60),
    );
  }

  void verifyOtp(String pin) async {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: pin);

    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        Get.snackbar(
          "Login Successfull",
          "Login is completed",
          snackPosition: SnackPosition.BOTTOM,
        );
      });
    } on FirebaseAuthException catch (e) {
      log("Error in verify otp ${e.message}");
    }
  }
}
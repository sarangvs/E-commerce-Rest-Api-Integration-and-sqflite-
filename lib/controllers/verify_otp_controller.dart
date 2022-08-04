import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:retailer_app/controllers/register_view_controller.dart';
import 'package:retailer_app/utils/utils.dart';
import 'package:retailer_app/view/home_view.dart';

class VerifyOtpController extends GetxController {
  final registerViewController = Get.find<RegisterViewController>();

  Future<void> verifyOtp(String pin) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: registerViewController.verId, smsCode: pin);

    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        Get.to(() => const HomeView());
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("${e.message}");

      log("Error in verify otp ${e.message}");
    }
  }
}

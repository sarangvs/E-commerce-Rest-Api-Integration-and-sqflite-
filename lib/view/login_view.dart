import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retailer_app/controllers/login_view_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = Get.put(LoginViewController());
  late TextEditingController phoneController;
  late TextEditingController otpController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    otpController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GetBuilder<LoginViewController>(builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !controller.verificationCodeSent
                  ? _textField(hintText: "Phone", controller: phoneController)
                  : _textField(hintText: "Otp", controller: otpController),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  !controller.verificationCodeSent
                      ? controller.verifyPhone(phoneController.text)
                      : controller.verifyOtp(otpController.text);
                },
                child:
                    Text(controller.verificationCodeSent ? "Done" : "Submit"),
              )
            ],
          );
        }),
      ),
    );
  }

  TextField _textField(
          {required String hintText,
          required TextEditingController controller}) =>
      TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 13.0,
            horizontal: 8,
          ),
          fillColor: Colors.grey[350],
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.black,
          ),
          filled: true,
        ),
      );
}

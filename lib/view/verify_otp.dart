import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retailer_app/controllers/verify_otp_controller.dart';

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({Key? key}) : super(key: key);

  @override
  _VerifyOtpViewState createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final verifyOtpController = Get.put(VerifyOtpController());

  late TextEditingController otpFirstValue;
  late TextEditingController otpSecondValue;
  late TextEditingController otpThirdValue;
  late TextEditingController otpFourthValue;
  late TextEditingController otpFifthValue;
  late TextEditingController otpSixthValue;

  @override
  void initState() {
    super.initState();
    otpFirstValue = TextEditingController();
    otpSecondValue = TextEditingController();
    otpThirdValue = TextEditingController();
    otpFourthValue = TextEditingController();
    otpFifthValue = TextEditingController();
    otpSixthValue = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    otpFirstValue.dispose();
    otpSecondValue.dispose();
    otpThirdValue.dispose();
    otpFourthValue.dispose();
    otpFifthValue.dispose();
    otpSixthValue.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 32,
            color: Colors.black54,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 18),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/illustration-3.png',
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(
                          first: true,
                          last: false,
                          controller: otpFirstValue,
                        ),
                        _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpSecondValue,
                        ),
                        _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpThirdValue,
                        ),
                        _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFourthValue,
                        ),
                        _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFifthValue,
                        ),
                        _textFieldOTP(
                          first: false,
                          last: true,
                          controller: otpSixthValue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          verifyOtpController.verifyOtp(
                            "${otpFirstValue.text}${otpSecondValue.text}${otpThirdValue.text}${otpFourthValue.text}${otpFifthValue.text}${otpSixthValue.text}",
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP(
      {required bool first, last, required TextEditingController controller}) {
    return SizedBox(
      height: 50,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.purple),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}

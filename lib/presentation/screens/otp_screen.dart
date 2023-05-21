import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_firebase_sqflite_bloc/presentation/screens/map_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import '../../business_logic/cubit/phone_auth/phone_auth_state.dart';
import '../../constants/my_colors.dart';
import '../../constants/strings.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key, this.phoneNumber}) : super(key: key);

  final phoneNumber;
  late String otpCode;

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify your phone number?',
          style: TextStyle(
            color: MyColors.textBlackColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Enter the 6-digit code sent to you at ',
                  style: TextStyle(
                    color: MyColors.textBlackColor,
                    fontSize: 18,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: phoneNumber,
                  style: TextStyle(
                    color: MyColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPinCodeField(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: MyColors.primaryColor!,
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          borderWidth: 1,
          activeColor: MyColors.primaryColor!.withOpacity(0.2),
          inactiveColor: MyColors.primaryColor!.withOpacity(0.2),
          inactiveFillColor: Colors.white,
          activeFillColor: MyColors.primaryColor!.withOpacity(0.2),
          selectedColor: MyColors.primaryColor!.withOpacity(0.2),
          selectedFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        onCompleted: (code) {
          otpCode = code;
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }
  Widget _buildVerifyButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          showProgressIndicator(context);
          _login(context);
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(110, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'Verify',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alert = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Row(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
          ),
          SizedBox(width: 16),
          Text("Loading..."),
        ],
      ),
    );
    showDialog(
      barrierColor: Colors.white.withOpacity(0.5),
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return alert;
      },
    );
  }

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return current != previous;
      },
      listener: (context, state) {
        if (state is PhoneAuthLoading) {
          showProgressIndicator(context);
        }
        if (state is PhoneOTPVerify) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, mapScreen);
        }
        if (state is PhoneAuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildIntroTexts(),
                const SizedBox(height: 60),
                _buildPinCodeField(context),
                const SizedBox(height: 50),
                _buildVerifyButton(context),
                _buildPhoneVerificationBloc(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

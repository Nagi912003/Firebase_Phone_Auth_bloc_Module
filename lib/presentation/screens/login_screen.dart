import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_firebase_sqflite_bloc/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps_firebase_sqflite_bloc/business_logic/cubit/phone_auth/phone_auth_state.dart';

import 'package:maps_firebase_sqflite_bloc/constants/my_colors.dart';

import '../../constants/strings.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _phoneFormKey = GlobalKey();

  late String phoneNumber;

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What is your phone number?',
          style: TextStyle(
            color: MyColors.textBlackColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: const Text(
            'please enter your phone number to verify your account',
            style: TextStyle(
              color: MyColors.textBlackColor,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPhoneFormField() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                  blurStyle: BlurStyle.outer,
                ),
              ],
              color: MyColors.primaryColor!.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${_generateCountryFlag()} +20',
              style: TextStyle(
                color: MyColors.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(
                color: MyColors.primaryColor!.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextFormField(
              autofocus: true,
              keyboardType: TextInputType.phone,
              cursorColor: MyColors.primaryColor,
              style: const TextStyle(
                letterSpacing: 2.0,
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                hintStyle: TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 13,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your phone number';
                } else if (value.length < 11) {
                  return 'to short for a phone number';
                }
                return null;
              },
              onSaved: (value) {
                phoneNumber = value!;
              },
            ),
          ),
        ),
      ],
    );
  }

  String _generateCountryFlag() {
    String countryCode = 'eg';
    String flag =
        countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'), (match) {
      return String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397);
    });
    return flag;
  }

  Future<void> _registerUser(BuildContext context) async {
    if (_phoneFormKey.currentState!.validate()) {
      Navigator.pop(context);
      _phoneFormKey.currentState!.save();
      print(phoneNumber);
      await BlocProvider.of<PhoneAuthCubit>(context).submitPhoneNumber(phoneNumber);
    }else{
      Navigator.pop(context);
      return;
    }
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          showProgressIndicator(context);

          _registerUser(context);
          // if (_phoneFormKey.currentState!.validate()) {
          //   _phoneFormKey.currentState!.save();
          //   print(phoneNumber);
            Navigator.pushNamed(context, otpScreen);
          //}
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(110, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'Next',
          style: TextStyle(
            fontSize: 16,
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
          CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),),
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

  Widget _buildPhoneNumberSubmitedBloc(BuildContext context){
    return BlocListener<PhoneAuthCubit,PhoneAuthState>(
      listenWhen: (previous, current) {
        return current != previous;
      },
      listener: (context, state) {
        if (state is PhoneAuthLoading) {
          showProgressIndicator(context);
        }
        if (state is PhoneNumberSubmitted) {
          Navigator.pop(context);
          Navigator.pushNamed(context, otpScreen, arguments: phoneNumber);
        }
        if (state is PhoneAuthError) {
          Navigator.pop(context);
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
        backgroundColor: Colors.white, //MyColors.primaryColor,
        body: Form(
          key: _phoneFormKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIntroTexts(),
                const SizedBox(height: 110),
                _buildPhoneFormField(),
                const SizedBox(height: 70),
                _buildNextButton(context),
                _buildPhoneNumberSubmitedBloc(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

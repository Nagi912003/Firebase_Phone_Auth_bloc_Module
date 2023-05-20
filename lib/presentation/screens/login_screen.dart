import 'package:flutter/material.dart';

import 'package:maps_firebase_sqflite_bloc/constants/my_colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

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

  Widget _buildNextButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {},
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white, //MyColors.primaryColor,
        body: Form(
          key: UniqueKey(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIntroTexts(),
                const SizedBox(height: 110),
                _buildPhoneFormField(),
                const SizedBox(height: 70),
                _buildNextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

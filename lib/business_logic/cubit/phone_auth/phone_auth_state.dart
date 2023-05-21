import 'package:flutter/foundation.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {}

class PhoneAuthError extends PhoneAuthState {
  final String message;

  PhoneAuthError({required this.message});
}

class PhoneNumberSubmitted extends PhoneAuthState {}

class PhoneOTPVerify extends PhoneAuthState {}
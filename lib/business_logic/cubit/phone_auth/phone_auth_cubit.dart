import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {

  late String verificationId;


  PhoneAuthCubit() : super(PhoneAuthInitial());


  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(PhoneAuthLoading());
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+2$phoneNumber',
        timeout: const Duration(seconds: 15),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      emit(PhoneAuthError(message: e.toString()));
    }
  }

  void verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    print('verificationCompleted');
    emit(PhoneAuthLoading());
    try {
      await signIn(phoneAuthCredential);
    } catch (e) {
      emit(PhoneAuthError(message: e.toString()));
    }
  }

  void verificationFailed(FirebaseAuthException e) {
    print('verificationFailed : ${e.message}');
    emit(PhoneAuthError(message: e.message!));
  }

  void codeSent(String verificationId, int? resendToken) {
    print('codeSent');
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otp) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await signIn(credential);
    } catch (e) {
      emit(PhoneAuthError(message: e.toString()));
    }
  }

  Future<void> signIn(PhoneAuthCredential phoneAuthCredential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      emit(PhoneOTPVerify());
    } catch (e) {
      emit(PhoneAuthError(message: e.toString()));
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    emit(PhoneAuthInitial());
  }

  User get user => FirebaseAuth.instance.currentUser!;
}
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Timer? _timer;
  final int _sessionTimeoutInSeconds = 300;

  void startSessionTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? loginTime = prefs.getString('loginTime');
      if (loginTime != null) {
        final DateTime loginDateTime = DateTime.parse(loginTime);
        final DateTime currentDateTime = DateTime.now();
        final int differenceInSeconds =
            currentDateTime.difference(loginDateTime).inSeconds;
        if (differenceInSeconds >= _sessionTimeoutInSeconds) {
          _logout();
        }
      }
    });
  }

  void submitAndGetOTP(String phoneNumber, String countryCode) async {
    emit(AuthLoading());
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.verifyPhoneNumber(
          timeout: const Duration(seconds: 120),
          verificationCompleted: (PhoneAuthCredential credential) {
            try {
              print(
                  '+++++++++++++++++++++++++++++++++====================================-----------------------------======================xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
            } catch (error) {
              AuthFailure(error: error.toString());
            }
          },
          verificationFailed: (FirebaseAuthException exception) async {
            AuthFailure(error: exception.message!);
          },
          codeSent: (String verificationCode, int? resendToken) async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.setString('loginTime', DateTime.now().toIso8601String());

            print("Received otp code $verificationCode");
            emit(AuthGetSuccess(verificationCode: verificationCode));
          },
          codeAutoRetrievalTimeout: (String verficationId) {},
          phoneNumber: '$countryCode $phoneNumber');
      
    } on FirebaseAuthException catch (error) {
      AuthFailure(error: error.message!);
    } catch (error) {
      AuthFailure(error: error.toString());
    }
  }

  void setToAuthInitial() {
    emit(AuthInitial());
  }

  void isOTPCorrect(String verificationCode, String smsCode) async {
    try {
      PhoneAuthCredential credential = await PhoneAuthProvider.credential(
          verificationId: verificationCode, smsCode: smsCode);
      FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        if (value.user != null) {
          emit(AuthSuccess());

          print("Phone number verify successfully");
          startSessionTimer();
        } else {
          emit(AuthFailure(error: 'Phone Number Verification failed'));
          print("Phone number verification failed");
        }
      }).catchError((error) {
        emit(AuthFailure(error: 'Error during verifying phone number'));
        print("Error during verifying phone number : $error");
      });
    } catch (error) {
      emit(AuthFailure(error: 'Error during verifying phone number'));
      print("Error during verifying Phone number");
    }
  }

  void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('loginTime');
    emit(AuthInitial());
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

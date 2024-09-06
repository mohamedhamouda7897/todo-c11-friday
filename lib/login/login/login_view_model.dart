import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c11_friday/base.dart';
import 'package:todo_c11_friday/login/login/login_connector.dart';

class LoginViewModel extends BaseViewModel<LoginConnector> {


  Future<void> loginUser(
    String email,
    String password,
  ) async {
    try {
      connector!.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      connector!.hideDialog();
      connector!.goToHome();
    } on FirebaseAuthException catch (e) {
      connector!.hideDialog();
      connector!.showErrorMessage(e.message.toString());
    } catch (e) {
      connector!.hideDialog();
      connector!.showErrorMessage(e.toString());
    }
  }
}

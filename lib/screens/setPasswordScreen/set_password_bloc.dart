import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../constant/constant.dart';
import '../../utils/utils.dart';

class SetPasswordBloc {
  BuildContext context;
  final subjectStatus = BehaviorSubject<Status>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SetPasswordBloc(this.context);

  void setNewPassword() async {
    final email = emailController.text.trim();

    if (formKey.currentState!.validate()) {
      subjectStatus.sink.add(Status.loading);
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(
            email: email)
            .then((value) async {
          Navigator.pop(context, true);
        });
      } on FirebaseAuthException catch (error) {
        subjectStatus.sink.add(Status.error);
        if (context.mounted) {
          if (error.code == 'auth/invalid-email') {
            openSimpleSnackBar('No user found for $email.');
          } else {
            debugPrint("errorCode =====> ${error.code}");
          }
        }
      }
    }
  }

  void dispose() {
    subjectStatus.close();
  }
}
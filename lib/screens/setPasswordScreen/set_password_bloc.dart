import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ui/main.dart';
import 'package:food_ui/utils/response_util.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/utils.dart';

class SetPasswordBloc {
  BuildContext context;
  final subjectStatus = BehaviorSubject<ResponseUtil>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SetPasswordBloc(this.context);

  void setNewPassword() async {
    final email = emailController.text.trim();

    if (formKey.currentState!.validate()) {
      subjectStatus.sink.add(ResponseUtil.loading());
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) async {
          subjectStatus.sink.add(ResponseUtil.completed());
          Navigator.pop(context, true);
        });
      } on FirebaseAuthException catch (error) {
        subjectStatus.sink.add(ResponseUtil.error(error.toString()));
        if (context.mounted) {
          if (error.code == 'auth/invalid-email') {
            openSimpleSnackBar('${languages.noUserFoundForEmail(email)}.');
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

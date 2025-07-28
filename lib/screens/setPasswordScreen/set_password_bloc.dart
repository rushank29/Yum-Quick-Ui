import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../customWidget/networkConnectivityChecker/internet_service.dart';
import '../../main.dart';
import '../../utils/response_util.dart';
import '../../utils/utils.dart';

class SetPasswordBloc {
  BuildContext context;

  SetPasswordBloc(this.context);

  final subjectStatus = BehaviorSubject<ResponseUtil>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void setNewPassword() async {
    final email = emailController.text.trim();

    if (formKey.currentState!.validate()) {
      subjectStatus.sink.add(ResponseUtil.loading());
      InternetService().runWhenOnline(() async {
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
      });
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    subjectStatus.close();
  }
}

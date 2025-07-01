import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_ui/main.dart';
import 'package:food_ui/screens/homeMainV1/home_main_v1.dart';
import 'package:food_ui/utils/response_util.dart';
import 'package:food_ui/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import '../signUpScreen/sign_up_dl.dart';

class LoginBloc {
  BuildContext context;
  final subjectStatus = BehaviorSubject<ResponseUtil>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginBloc(this.context);

  void userLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      openSimpleSnackBar(languages.enterBothEmailAndPassword);
      return;
    }
    if (formKey.currentState!.validate()) {
      subjectStatus.sink.add(ResponseUtil.loading());
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(), password: passwordController.text.trim())
            .then((value) async {
          User? currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            //  If successfully logged in (credentials are correct)
            DatabaseReference dbRef = FirebaseDatabase.instance.ref("${currentUser.uid}/user");
            final snapshot = await dbRef.get();
            if(!context.mounted) return;
            if (snapshot.exists) {
              SignUpPojo userMap = SignUpPojo.fromJson(snapshot.value as Map);
              setUserDataInPref(0, currentUser, signUpPojo: userMap);
              subjectStatus.sink.add(ResponseUtil.completed());
              openScreenWithClearPrevious(context: context, screen: const HomeMainV1());
            } else {
              subjectStatus.sink.add(ResponseUtil.error("No user found for the $email."));
              openSimpleSnackBar('No user found for the $email.');
            }
          } else {
            userLogin();
          }
        });
      } on FirebaseAuthException catch (error) {
        subjectStatus.sink.add(ResponseUtil.error(error.toString()));
        if (context.mounted) {
          if (error.code == 'user-not-found') {
            openSimpleSnackBar(languages.noUserFoundForEmail(email));
          } else if (error.code == 'wrong-password') {
            openSimpleSnackBar(languages.wrongPasswordProvidedByTheUser);
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

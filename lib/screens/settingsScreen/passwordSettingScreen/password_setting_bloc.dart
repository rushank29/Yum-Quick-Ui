import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../customWidget/networkConnectivityChecker/internet_service.dart';
import '../../../main.dart';
import '../../../shared_pref_util/shared_pref_constants.dart';
import '../../../shared_pref_util/shared_pref_util.dart';
import '../../../utils/response_util.dart';
import '../../../utils/utils.dart';
import '../../signUpScreen/sign_up_dl.dart';

class PasswordSettingBloc {
  final BuildContext context;

  PasswordSettingBloc(this.context);

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final subjectStatus = BehaviorSubject<ResponseUtil>();

  void userChangePassword() async {
    final code = codeController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final oldPassword = oldPasswordController.text.trim();

    User? currentUser = FirebaseAuth.instance.currentUser;
    DatabaseReference dbRef = FirebaseDatabase.instance.ref("${currentUser?.uid}/user");
    final DataSnapshot snapshot = await dbRef.get();
    SignUpPojo response = SignUpPojo.fromJson(snapshot.value as Map);
    if (code.isEmpty || newPassword.isEmpty || oldPassword.isEmpty) {
      openSimpleSnackBar(languages.enterCodeAndBothPasswords);
      return;
    } else if (snapshot.exists && response.userPassword != oldPasswordController.text.trim()) {
      openSimpleSnackBar("The old password doesn't match!");
    }
    if (formKey.currentState!.validate()) {
      subjectStatus.sink.add(ResponseUtil.loading());
      InternetService().runWhenOnline(() async {
        try {
          await FirebaseAuth.instance
              .confirmPasswordReset(
                  code: codeController.text.trim(), newPassword: newPasswordController.text.trim())
              .then((value) async {
            if (currentUser != null) {
              //  If successfully logged in (credentials are correct)
              final snapshot = await dbRef.get();
              if (!context.mounted) return;
              if (snapshot.exists) {
                Map<String, dynamic> userMap = mapUserData(currentUser);
                await dbRef.update(userMap).then((value) async {
                  setUserDataInPref(
                    getInt(prefUserLoginType),
                    currentUser,
                    signUpPojo: SignUpPojo.fromJson(userMap),
                  );
                });
                subjectStatus.sink.add(ResponseUtil.completed());
                if (!context.mounted) return;
                Navigator.pop(context);
              } else {
                subjectStatus.sink
                    .add(ResponseUtil.error("No user found for the ${getString(prefUserEmail)}."));
                openSimpleSnackBar('No user found for the ${getString(prefUserEmail)}.');
              }
            } else {
              userChangePassword();
            }
          });
        } on FirebaseAuthException catch (error) {
          subjectStatus.sink.add(ResponseUtil.error(error.toString()));
          if (context.mounted) {
            if (error.code == 'user-not-found') {
              openSimpleSnackBar('No user found for ${getString(prefUserEmail)}.');
            } else if (error.code == 'wrong-password') {
              openSimpleSnackBar("Wrong password provided by the user.");
            } else {
              debugPrint("errorCode =====> ${error.code}");
            }
          }
        }
      });
    }
  }

  Map<String, dynamic> mapUserData(User currentUser, {String? image}) {
    SignUpPojo userData = SignUpPojo(
      userPassword: newPasswordController.text.trim(),
    );
    return userData.toJson();
  }

  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    codeController.dispose();
    subjectStatus.close();
  }
}

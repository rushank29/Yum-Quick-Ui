import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import '../../customWidget/networkConnectivityChecker/internet_service.dart';
import '../../main.dart';
import '../homeMainV1/home_main_v1.dart';
import '../../utils/response_util.dart';
import '../../utils/utils.dart';
import 'sign_up_dl.dart';

class SignUpBloc {
  BuildContext context;
  final selectedCountrySubject = BehaviorSubject<CountryCode?>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final birthDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final subjectStatus = BehaviorSubject<ResponseUtil>();

  SignUpBloc(this.context);

  void userSignUp() async {
    final fullName = fullNameController.text.trim();
    final birthDate = birthDateController.text.trim();
    final mobileNo = mobileNumberController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty || fullName.isEmpty || birthDate.isEmpty || mobileNo.isEmpty) {
      openSimpleSnackBar(languages.fillUpFullForm);
      return;
    }
    if (formKey.currentState!.validate()) {
      subjectStatus.sink.add(ResponseUtil.loading());
      InternetService().runWhenOnline(() async {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController.text.trim(), password: passwordController.text.trim())
              .then((value) async {
            User? currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
              //  If successfully logged in (credentials are correct)
              DatabaseReference dbRef = FirebaseDatabase.instance.ref("${currentUser.uid}/user");
              final snapshot = await dbRef.get();
              Map<String, dynamic> userMap = mapUserData(currentUser);
              if (context.mounted) {
                if (snapshot.exists) {
                  dbRef.set(userMap);
                  setUserDataInPref(0, currentUser, signUpPojo: SignUpPojo.fromJson(userMap));
                  subjectStatus.sink.add(ResponseUtil.completed());
                } else {
                  snapshot.ref.set(userMap);
                  setUserDataInPref(0, currentUser, signUpPojo: SignUpPojo.fromJson(userMap));
                  subjectStatus.sink.add(ResponseUtil.completed());
                }
                openScreenWithClearPrevious(context: context, screen: const HomeMainV1());
              }
            } else {
              userSignUp();
            }
          });
        } on FirebaseAuthException catch (error) {
          subjectStatus.sink.add(ResponseUtil.error(error.toString()));
          if (context.mounted) {
            if (error.code == 'email-already-in-use') {
              openSimpleSnackBar('${languages.userExistMsg} $email.');
            } else if (error.code == 'invalid-email') {
              openSimpleSnackBar(languages.checkEmailMsg);
            } else if (error.code == 'weak-password') {
              openSimpleSnackBar(languages.weakPasswordMsg);
            } else {
              debugPrint("errorCode =====> ${error.code}");
            }
          }
        }
      });
    }
  }

  Map<String, dynamic> mapUserData(User currentUser) {
    SignUpPojo userData = SignUpPojo(
      userId: currentUser.uid,
      userName: fullNameController.text.trim(),
      userEmail: currentUser.email ?? emailController.text.trim(),
      userBirthDate: birthDateController.text.trim(),
      userPassword: passwordController.text.trim(),
      userCountryCode: selectedCountrySubject.valueOrNull?.dialCode,
      userMobile: mobileNumberController.text.trim(),
      userProfilePic: currentUser.photoURL,
      userLoginType: 0,
    );
    return userData.toJson();
  }

  void dispose() {
    subjectStatus.close();
    selectedCountrySubject.close();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileNumberController.dispose();
    birthDateController.dispose();
  }
}

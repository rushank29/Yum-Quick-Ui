import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_ui/constant/constant.dart';
import 'package:food_ui/screens/homeMainV1/home_main_v1.dart';
import 'package:food_ui/screens/signUpScreen/sign_up_dl.dart';
import 'package:food_ui/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc {
  BuildContext context;
  final selectedCountrySubject = BehaviorSubject<CountryCode?>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final birthDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final subjectStatus = BehaviorSubject<Status>();

  SignUpBloc(this.context);

  void showTimePicker() async {
    String formattedDate = birthDateController.text;
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    DateTime? selectedDateTime = formattedDate.isNotEmpty ? formatter.parse(formattedDate) : DateTime(2000);
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDateTime,
        firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now());

    if (pickedDate != null) {
      debugPrint("pickedDate ==> $pickedDate");
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      debugPrint("formattedDate ==> $formattedDate");
      birthDateController.text = formattedDate;
    } else {
      debugPrint("Date is not selected");
    }
  }

  void userSignUp() async {
    final fullName = fullNameController.text.trim();
    final birthDate = birthDateController.text.trim();
    final mobileNo = mobileNumberController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty || fullName.isEmpty || birthDate.isEmpty || mobileNo.isEmpty) {
      openSimpleSnackBar('Please fill up the full form.');
      return;
    }
    if (formKey.currentState!.validate()) {
      subjectStatus.sink.add(Status.loading);
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
                setUserDataInPref(currentUser, signUpPojo: SignUpPojo.fromJson(userMap));
                subjectStatus.sink.add(Status.completed);
              } else {
                snapshot.ref.set(userMap);
                setUserDataInPref(currentUser, signUpPojo: SignUpPojo.fromJson(userMap));
                subjectStatus.sink.add(Status.completed);
              }
              openScreenWithClearPrevious(context: context, screen: const HomeMainV1());
            }
          } else {
            userSignUp();
          }
        });
      } on FirebaseAuthException catch (error) {
        subjectStatus.sink.add(Status.error);
        if (context.mounted) {
          if (error.code == 'email-already-in-use') {
            openSimpleSnackBar('User already exist for that $email.');
          } else if (error.code == 'invalid-email') {
            openSimpleSnackBar("Please check your email address.");
          } else if (error.code == 'weak-password') {
            openSimpleSnackBar("Weak password provided by the User.");
          } else {
            debugPrint("errorCode =====> ${error.code}");
          }
        }
      }
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
    );
    return userData.toJson();
  }

  void dispose() {
    subjectStatus.close();
  }
}

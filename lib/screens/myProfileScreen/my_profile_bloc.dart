import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ui/screens/signUpScreen/sign_up_dl.dart';
import 'package:food_ui/shared_pref_util/shared_pref_constants.dart';
import 'package:food_ui/shared_pref_util/shared_pref_util.dart';
import 'package:food_ui/utils/response_util.dart';
import 'package:food_ui/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/image_picker.dart';

class MyProfileBloc {
  final BuildContext context;

  MyProfileBloc(this.context) {
    getProfileData();
  }

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final birthDateController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? imageFile;

  final currentUser = FirebaseAuth.instance.currentUser;

  final subjectGetDataStatus = BehaviorSubject<ResponseUtil>();
  final subjectSetDataStatus = BehaviorSubject<ResponseUtil>();
  final networkImageSubject = BehaviorSubject<String>();
  final isFileImageSubject = BehaviorSubject<bool>();
  final selectedCountrySubject = BehaviorSubject<CountryCode?>();

  void getProfileData() async {
    subjectGetDataStatus.sink.add(ResponseUtil.loading());
    DatabaseReference dbRef = FirebaseDatabase.instance.ref("${currentUser?.uid}/user");
    final DataSnapshot snapshot = await dbRef.get();
    if (snapshot.exists) {
      print("snapshot =============> ${snapshot.value}");
      SignUpPojo response = SignUpPojo.fromJson(snapshot.value as Map);
      networkImageSubject.sink.add(response.userProfilePic);
      isFileImageSubject.sink.add(false);
      fullNameController.text = response.userName;
      emailController.text = response.userEmail;
      birthDateController.text = response.userBirthDate;
      mobileNumberController.text = response.userMobile;
      selectedCountrySubject.sink.add(
        response.userCountryCode.isEmpty ? null : CountryCode.tryFromDialCode(response.userCountryCode),
      );
      subjectGetDataStatus.sink.add(ResponseUtil.completed());
    } else {
      subjectGetDataStatus.sink.add(ResponseUtil.error("No data available."));
      debugPrint('No data available.');
      openSimpleSnackBar('No data available.');
    }
  }

  void updateProfile() async {
    final fullName = fullNameController.text.trim();
    final birthDate = birthDateController.text.trim();
    final mobileNo = mobileNumberController.text.trim();
    final email = emailController.text.trim();

    if (email.isEmpty || fullName.isEmpty || birthDate.isEmpty || mobileNo.isEmpty) {
      openSimpleSnackBar('Please fill-up the full form.');
      return;
    }
    String? downloadUrl;
    if (formKey.currentState!.validate()) {
      subjectSetDataStatus.sink.add(ResponseUtil.loading());

      if (currentUser != null) {
        DatabaseReference dbRef = FirebaseDatabase.instance.ref("${currentUser!.uid}/user");
        final snapshot = await dbRef.get();
        if (snapshot.exists) {
          if (imageFile != null) {
            //  adding user profile pic to firebase storage
            Reference storageReference = FirebaseStorage.instance
                .ref()
                .child('${currentUser!.uid}/user_profile_pic/${DateTime.now()}.png');
            UploadTask uploadTask = storageReference.putFile(imageFile!);
            TaskSnapshot storageTaskSnapshot = await uploadTask;
            downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
          }
          Map<String, dynamic> userMap = mapUserData(currentUser!, image: downloadUrl);
          await dbRef.update(userMap).then((value) async {
              setUserDataInPref(
                prefs?.getInt(prefUserLoginType) ?? 0,
                currentUser!,
                signUpPojo: SignUpPojo.fromJson(userMap),
              );
              openSimpleSnackBar("User ${fullNameController.text.trim()} updated successfully.");
              subjectSetDataStatus.sink.add(ResponseUtil.completed());
              await Future.delayed(const Duration(seconds: 2));
            if (context.mounted) {
              Navigator.pop(context, true);
            }
          });
        }
      } else {
        subjectSetDataStatus.sink.add(ResponseUtil.error("Error occurred while updating your profile"));
        openSimpleSnackBar("Error occurred while updating your profile");
      }
    }
  }

  Map<String, dynamic> mapUserData(User currentUser, {String? image}) {
    SignUpPojo userData = SignUpPojo(
      userId: currentUser.uid,
      userName: fullNameController.text.trim(),
      userEmail: currentUser.email ?? emailController.text.trim(),
      userBirthDate: birthDateController.text.trim(),
      userCountryCode: selectedCountrySubject.valueOrNull?.dialCode,
      userMobile: mobileNumberController.text.trim(),
      userProfilePic: image ?? currentUser.photoURL,
      userLoginType: prefs?.getInt(prefUserLoginType) ?? 0,
    );
    return userData.toJson();
  }

  void selectImage() {
    handlePermission(
      context,
      onGalleryImageSelected: (selectedImage) {
        imageFile = selectedImage;
        isFileImageSubject.sink.add(true);
      },
      onCameraImageSelected: (selectedImage) {
        imageFile = selectedImage;
        isFileImageSubject.sink.add(true);
      },
    );
  }

  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    birthDateController.dispose();
    mobileNumberController.dispose();
    networkImageSubject.close();
    isFileImageSubject.close();
    selectedCountrySubject.close();
  }
}

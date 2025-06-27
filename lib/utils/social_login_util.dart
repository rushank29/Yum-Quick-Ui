import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/screens/biometricLoginScreen/biometric_login_screen.dart';
import 'package:food_ui/screens/homeMainV1/home_main_v1.dart';
import 'package:food_ui/utils/response_util.dart';
import 'package:food_ui/utils/text_style.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

import '../constant/dimensions.dart';
import '../screens/signUpScreen/sign_up_dl.dart';
import 'utils.dart';

class SocialLoginUtil extends StatefulWidget {
  final bool isFromLogin;
  final BehaviorSubject<ResponseUtil>? subjectStatus;

  const SocialLoginUtil({super.key, this.isFromLogin = false, this.subjectStatus});

  @override
  State<SocialLoginUtil> createState() => _SocialLoginUtilState();
}

class _SocialLoginUtilState extends State<SocialLoginUtil> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "or sign up with",
          style: bodyText(textColor: colorDarkGrey),
        ),
        SizedBox(height: commonPadding10px),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _socialLoginCommonWidget(
              svgPicture: "assets/svg/google_login.svg",
              onTap: () {
                _googleSignIn();
              },
            ),
            SizedBox(width: commonPadding10px),
            _socialLoginCommonWidget(
              svgPicture: "assets/svg/facebook_login.svg",
              onTap: () {},
            ),
            SizedBox(width: commonPadding10px),
            _socialLoginCommonWidget(
              svgPicture: "assets/svg/biometric_login.svg",
              onTap: () {
                openScreenWithReplacePrevious(context: context, screen: const BiometricLoginScreen());
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialLoginCommonWidget({required String svgPicture, required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsDirectional.all(commonPadding10px),
        decoration: BoxDecoration(
          color: colorLightOrange,
          borderRadius: BorderRadiusDirectional.circular(borderRadius13px),
        ),
        child: SvgPicture.asset(
          svgPicture,
          height: iconSize20px,
          width: iconSize20px,
        ),
      ),
    );
  }

  void _googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential).then(
        (value) async {
          //  If successfully logged in (credentials are correct)
          User? currentUser = value.user;
          if (currentUser != null) {
            setUserDataInPref(1, currentUser);
            //  If successfully logged in (credentials are correct)
            DatabaseReference dbRef = FirebaseDatabase.instance.ref("${currentUser.uid}/user");
            final snapshot = await dbRef.get();
            if (context.mounted) {
              if (!widget.isFromLogin) {
                if (snapshot.exists) {
                  dbRef.set(userMap(currentUser));
                  setUserDataInPref(1, currentUser, signUpPojo: SignUpPojo.fromJson(userMap(currentUser)));
                  widget.subjectStatus?.sink.add(ResponseUtil.completed());
                } else {
                  snapshot.ref.set(userMap(currentUser));
                  setUserDataInPref(1, currentUser, signUpPojo: SignUpPojo.fromJson(userMap(currentUser)));
                  widget.subjectStatus?.sink.add(ResponseUtil.completed());
                }
                openScreenWithClearPrevious(context: context, screen: const HomeMainV1());
              } else {
                if (snapshot.exists) {
                  SignUpPojo userMap = SignUpPojo.fromJson(snapshot.value as Map);
                  setUserDataInPref(1, currentUser, signUpPojo: userMap);
                  widget.subjectStatus?.sink.add(ResponseUtil.completed());
                  openScreenWithClearPrevious(context: context, screen: const HomeMainV1());
                } else {
                  widget.subjectStatus?.sink
                      .add(ResponseUtil.error('No user found for the ${currentUser.email}.'));
                  openSimpleSnackBar('No user found for the ${currentUser.email}.');
                }
              }
            }
          } else {
            _googleSignIn();
          }
        },
      );
    } catch (error) {
      print('Error occurred while signing you in, $error');
      // openSimpleSnackBar('Error occurred while signing you in, $error');
    }
  }

  Map<String, dynamic> userMap(User currentUser) {
    SignUpPojo userData = SignUpPojo(
      userId: currentUser.uid,
      userName: currentUser.displayName,
      userEmail: currentUser.email,
      userProfilePic: currentUser.photoURL,
      userMobile: currentUser.phoneNumber,
      userLoginType: 1,
    );
    return userData.toJson();
  }
}

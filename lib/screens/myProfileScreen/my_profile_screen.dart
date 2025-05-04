import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/customWidget/common_bg_screen.dart';
import 'package:food_ui/customWidget/custom_image.dart';
import 'package:food_ui/screens/myProfileScreen/my_profile_bloc.dart';
import 'package:food_ui/screens/myProfileScreen/my_profile_shimmer.dart';
import 'package:food_ui/shared_pref_util/shared_pref_constants.dart';
import 'package:food_ui/utils/response_util.dart';

import '../../constant/constant.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../customWidget/custom_text_form_field.dart';
import '../../shared_pref_util/shared_pref_util.dart';
import '../../utils/utils.dart';
import '../../utils/validator_util.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  MyProfileBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= MyProfileBloc(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: "My Profile",
      bodyWidget: StreamBuilder<ResponseUtil>(
          stream: _bloc?.subjectGetDataStatus,
          builder: (context, snapStatus) {
            switch (snapStatus.data?.status ?? Status.loading) {
              case Status.loading:
                return const MyProfileShimmer();
              case Status.completed:
                return _myProfileBody();
              case Status.error:
                return _myProfileBody();
            }
          }),
    );
  }

  Widget _myProfileBody() {
    return Form(
      key: _bloc!.formKey,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              _bloc?.selectImage();
            },
            child: SizedBox(
              height: deviceAvgScreenSize * 0.2593,
              width: deviceAvgScreenSize * 0.2593,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: StreamBuilder<bool>(
                      stream: _bloc?.isFileImageSubject,
                      builder: (context, snapImage) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(borderRadius20px),
                          child: (snapImage.data == false || snapImage.data == null)
                              ? CustomImage(
                                  imagePath: _bloc?.currentUser?.photoURL ?? "",
                                  showDefaultImage: true,
                                  width: commonSize128px,
                                  height: commonSize128px,
                                  borderRadius: BorderRadius.circular(borderRadius20px),
                                )
                              : Image.file(
                                  _bloc!.imageFile!,
                                  width: commonSize128px,
                                  height: commonSize128px,
                                  fit: BoxFit.cover,
                                ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(commonPadding10px * 0.5),
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadiusDirectional.circular(borderRadius10px),
                      ),
                      child: SvgPicture.asset(
                        "assets/svg/camera.svg",
                        height: iconSize20px,
                        width: iconSize20px,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: commonPadding35px),
          CustomTextFormField(
            formFieldLabel: "Full name",
            controller: _bloc?.fullNameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              return validateEmptyField(value, "Please enter your name.");
            },
          ),
          SizedBox(height: commonPadding10px * 1.5),
          CustomTextFormField(
            formFieldLabel: "Date of birth",
            controller: _bloc?.birthDateController,
            readOnly: true,
            onTap: () {
              showDateSelector(context: context, controller: _bloc!.birthDateController);
            },
            keyboardType: TextInputType.datetime,
            validator: (value) {
              return validateEmptyField(value, "Please select your birth date!");
            },
          ),
          SizedBox(height: commonPadding10px * 1.5),
          CustomTextFormField(
            formFieldLabel: "Email",
            controller: _bloc?.emailController,
            readOnly: true,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              return validateEmail(value);
            },
          ),
          SizedBox(height: commonPadding10px * 1.5),
          CustomTextFormField(
            formFieldLabel: "Mobile Number",
            controller: _bloc?.mobileNumberController,
            keyboardType: TextInputType.phone,
            prefix: CountryCodePicker(
              showFlagMain: false,
              initialSelection: prefs?.getString(prefUserCountryCode),
              onInit: (value) {
                _bloc?.selectedCountrySubject.sink.add(value);
              },
              onChanged: (value) {
                _bloc?.selectedCountrySubject.sink.add(value);
              },
            ),
            validator: (value) {
              return validateEmptyField(value, "Please enter your mobile number!");
            },
          ),
          SizedBox(height: commonPadding32px),
          StreamBuilder<ResponseUtil>(
            stream: _bloc?.subjectSetDataStatus,
            builder: (context, snapSetStatus) {
              return CustomRoundedButton(
                buttonText: "Update Profile",
                onPressed: () {
                  _bloc?.updateProfile();
                },
                setProgress: snapSetStatus.data?.status == Status.loading,
              );
            }
          )
        ],
      ),
    );
  }
}

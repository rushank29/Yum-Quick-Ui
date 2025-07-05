import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constant/colors.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../customWidget/custom_image.dart';
import 'my_profile_bloc.dart';
import 'my_profile_shimmer.dart';
import '../../shared_pref_util/shared_pref_constants.dart';
import '../../utils/response_util.dart';
import '../../constant/constant.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../customWidget/custom_text_form_field.dart';
import '../../main.dart';
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
      pageTitle: languages.myProfile,
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
          _profileImage(),
          SizedBox(height: commonPadding35px),
          _fullNameField(),
          SizedBox(height: deviceAvgScreenSize * 0.0268425),
          _birthDateField(),
          SizedBox(height: deviceAvgScreenSize * 0.0268425),
          _emailField(),
          SizedBox(height: deviceAvgScreenSize * 0.0268425),
          _mobileNumberField(),
          SizedBox(height: commonPadding32px),
          _updateButton(),
        ],
      ),
    );
  }

  Widget _profileImage() {
    return GestureDetector(
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
                padding: EdgeInsets.all(deviceAvgScreenSize * 0.008945),
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
    );
  }

  Widget _fullNameField() {
    return CustomTextFormField(
      formFieldLabel: languages.fullName,
      controller: _bloc?.fullNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        return validateEmptyField(value, languages.enterYourName);
      },
    );
  }

  Widget _birthDateField() {
    return CustomTextFormField(
      formFieldLabel: languages.dateOfBirth,
      controller: _bloc?.birthDateController,
      readOnly: true,
      onTap: () {
        showDateSelector(context: context, controller: _bloc!.birthDateController);
      },
      keyboardType: TextInputType.datetime,
      validator: (value) {
        return validateEmptyField(value, languages.selectDateOfBirth);
      },
    );
  }

  Widget _emailField() {
    return CustomTextFormField(
      formFieldLabel: languages.email,
      controller: _bloc?.emailController,
      readOnly: true,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        return validateEmail(value);
      },
    );
  }

  Widget _mobileNumberField() {
    return CustomTextFormField(
      formFieldLabel: languages.mobileNumber,
      controller: _bloc?.mobileNumberController,
      keyboardType: TextInputType.phone,
      prefix: CountryCodePicker(
        showFlagMain: false,
        initialSelection: (prefs?.getString(prefUserCountryCode) ?? "").isNotEmpty
            ? prefs?.getString(prefUserCountryCode)
            : "+91",
        onInit: (value) {
          _bloc?.selectedCountrySubject.sink.add(value);
        },
        onChanged: (value) {
          _bloc?.selectedCountrySubject.sink.add(value);
        },
      ),
      validator: (value) {
        return validateEmptyField(value, languages.enterMobileNumber);
      },
    );
  }

  Widget _updateButton() {
    return StreamBuilder<ResponseUtil>(
      stream: _bloc?.subjectSetDataStatus,
      builder: (context, snapSetStatus) {
        return CustomRoundedButton(
          buttonText: languages.updateProfile,
          minBtnHeight: 0.048,
          minBtnWidth: 0.4,
          onPressed: () {
            _bloc?.updateProfile();
          },
          setProgress: snapSetStatus.data?.status == Status.loading,
        );
      },
    );
  }
}

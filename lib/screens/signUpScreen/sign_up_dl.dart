/// user_name : "Ramakant"
/// user_email : "ramakant@gmail.com"
/// user_password : "Ramakant@12"
/// user_mobile : "9876543210"
/// user_country_code : "+91"
/// user_birth_date : "16-10-2005"
/// user_login_type : 0 -> email, 1 -> google

class SignUpPojo {
  SignUpPojo({
    String? userName,
    String? userId,
    String? userProfilePic,
    String? userEmail,
    String? userPassword,
    String? userMobile,
    String? userCountryCode,
    String? userBirthDate,
    int? userLoginType,
  }) {
    _userName = userName;
    _userId = userId;
    _userProfilePic = userProfilePic;
    _userEmail = userEmail;
    _userPassword = userPassword;
    _userMobile = userMobile;
    _userCountryCode = userCountryCode;
    _userBirthDate = userBirthDate;
    _userLoginType = userLoginType;
  }

  SignUpPojo.fromJson(dynamic json) {
    _userName = json['user_name'];
    _userId = json['user_id'];
    _userProfilePic = json['user_profile_pic'];
    _userEmail = json['user_email'];
    _userPassword = json['user_password'];
    _userMobile = json['user_mobile'];
    _userCountryCode = json['user_country_code'];
    _userBirthDate = json['user_birth_date'];
    _userLoginType = json['user_login_type'];
  }

  String? _userName;
  String? _userId;
  String? _userProfilePic;
  String? _userEmail;
  String? _userPassword;
  String? _userMobile;
  String? _userCountryCode;
  String? _userBirthDate;
  int? _userLoginType;

  String get userName => _userName ?? "";

  String get userId => _userId ?? "";
  String get userProfilePic => _userProfilePic ?? "";

  String get userEmail => _userEmail ?? "";

  String get userPassword => _userPassword ?? "";

  String get userMobile => _userMobile ?? "";

  String get userCountryCode => _userCountryCode ?? "";

  String get userBirthDate => _userBirthDate ?? "";
  int get userLoginType => _userLoginType ?? 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['user_id'] = _userId;
    map['user_profile_pic'] = _userProfilePic;
    map['user_email'] = _userEmail;
    map['user_password'] = _userPassword;
    map['user_mobile'] = _userMobile;
    map['user_country_code'] = _userCountryCode;
    map['user_birth_date'] = _userBirthDate;
    map['user_login_type'] = _userLoginType;
    return map;
  }
}

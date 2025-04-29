import 'package:intl/intl.dart';

/// user_name : "Ramakant"
/// user_email : "ramakant@gmail.com"
/// user_password : "Ramakant@12"
/// user_mobile : "9876543210"
/// user_country_code : "+91"
/// user_birth_date : "16-10-2005"

class SignUpPojo {
  SignUpPojo({
      String? userName, 
      String? userId,
      String? userEmail,
      String? userPassword, 
      String? userMobile, 
      String? userCountryCode, 
      String? userBirthDate,}){
    _userName = userName;
    _userId = userId;
    _userEmail = userEmail;
    _userPassword = userPassword;
    _userMobile = userMobile;
    _userCountryCode = userCountryCode;
    _userBirthDate = userBirthDate;
}

  SignUpPojo.fromJson(dynamic json) {
    _userName = json['user_name'];
    _userId = json['user_id'];
    _userEmail = json['user_email'];
    _userPassword = json['user_password'];
    _userMobile = json['user_mobile'];
    _userCountryCode = json['user_country_code'];
    _userBirthDate = json['user_birth_date'];
  }
  String? _userName;
  String? _userId;
  String? _userEmail;
  String? _userPassword;
  String? _userMobile;
  String? _userCountryCode;
  String? _userBirthDate;

  String get userName => _userName ?? "";
  String get userId => _userId ?? "";
  String get userEmail => _userEmail ?? "";
  String get userPassword => _userPassword ?? "";
  String get userMobile => _userMobile ?? "";
  String get userCountryCode => _userCountryCode ?? "";
  String get userBirthDate => _userBirthDate ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['user_id'] = _userId;
    map['user_email'] = _userEmail;
    map['user_password'] = _userPassword;
    map['user_mobile'] = _userMobile;
    map['user_country_code'] = _userCountryCode;
    map['user_birth_date'] = _userBirthDate;
    return map;
  }

}
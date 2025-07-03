// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Best Seller`
  String get bestSeller {
    return Intl.message(
      'Best Seller',
      name: 'bestSeller',
      desc: '',
      args: [],
    );
  }

  /// `Discover our most popular dishes!`
  String get discoverPopularDishes {
    return Intl.message(
      'Discover our most popular dishes!',
      name: 'discoverPopularDishes',
      desc: '',
      args: [],
    );
  }

  /// `Set Your Fingerprint`
  String get setYourFingerPrint {
    return Intl.message(
      'Set Your Fingerprint',
      name: 'setYourFingerPrint',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.`
  String get loremIpsum {
    return Intl.message(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      name: 'loremIpsum',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueTxt {
    return Intl.message(
      'Continue',
      name: 'continueTxt',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get cancelOrder {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Other reasons...`
  String get otherReasons {
    return Intl.message(
      'Other reasons...',
      name: 'otherReasons',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been placed successfully`
  String get orderPlacedSuccessful {
    return Intl.message(
      'Your order has been placed successfully',
      name: 'orderPlacedSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been successfully cancelled`
  String get orderSuccessfullyCancelled {
    return Intl.message(
      'Your order has been successfully cancelled',
      name: 'orderSuccessfullyCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Delivery by`
  String get deliveryBy {
    return Intl.message(
      'Delivery by',
      name: 'deliveryBy',
      desc: '',
      args: [],
    );
  }

  /// `Track my order`
  String get trackMyOrder {
    return Intl.message(
      'Track my order',
      name: 'trackMyOrder',
      desc: '',
      args: [],
    );
  }

  /// `If you have any question reach directly to our customer support`
  String get ifQuestionsReachSupport {
    return Intl.message(
      'If you have any question reach directly to our customer support',
      name: 'ifQuestionsReachSupport',
      desc: '',
      args: [],
    );
  }

  /// `¡Order Confirmed!`
  String get orderConfirmed {
    return Intl.message(
      '¡Order Confirmed!',
      name: 'orderConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `¡Order Cancelled!`
  String get orderCancelled {
    return Intl.message(
      '¡Order Cancelled!',
      name: 'orderCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get placeOrder {
    return Intl.message(
      'Place Order',
      name: 'placeOrder',
      desc: '',
      args: [],
    );
  }

  /// `items`
  String get items {
    return Intl.message(
      'items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get orderSummary {
    return Intl.message(
      'Order Summary',
      name: 'orderSummary',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Order`
  String get confirmOrder {
    return Intl.message(
      'Confirm Order',
      name: 'confirmOrder',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get shippingAddress {
    return Intl.message(
      'Shipping Address',
      name: 'shippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subTotal {
    return Intl.message(
      'Subtotal',
      name: 'subTotal',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Tax and Fees`
  String get taxAndFees {
    return Intl.message(
      'Tax and Fees',
      name: 'taxAndFees',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Please select the cancellation reason or enter the one!`
  String get selectOrEnterCancellationReason {
    return Intl.message(
      'Please select the cancellation reason or enter the one!',
      name: 'selectOrEnterCancellationReason',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get deliveryAddress {
    return Intl.message(
      'Delivery Address',
      name: 'deliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any delivery addresses set, currently.`
  String get noDeliveryAddressSet {
    return Intl.message(
      'You don\'t have any delivery addresses set, currently.',
      name: 'noDeliveryAddressSet',
      desc: '',
      args: [],
    );
  }

  /// `No address found in prefs or delivery list not ready.`
  String get noAddressFoundInPref {
    return Intl.message(
      'No address found in prefs or delivery list not ready.',
      name: 'noAddressFoundInPref',
      desc: '',
      args: [],
    );
  }

  /// `Add New Address`
  String get addNewAddress {
    return Intl.message(
      'Add New Address',
      name: 'addNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the address name`
  String get enterAddressName {
    return Intl.message(
      'Please enter the address name',
      name: 'enterAddressName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the full address in descriptive form!`
  String get enterFullAddressInDescriptive {
    return Intl.message(
      'Please enter the full address in descriptive form!',
      name: 'enterFullAddressInDescriptive',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get popular {
    return Intl.message(
      'Popular',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sortBy {
    return Intl.message(
      'Sort By',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `New Account`
  String get newAccount {
    return Intl.message(
      'New Account',
      name: 'newAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Please select your birth date!`
  String get selectDateOfBirth {
    return Intl.message(
      'Please select your birth date!',
      name: 'selectDateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name.`
  String get enterYourName {
    return Intl.message(
      'Please enter your name.',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get enterValidEmail {
    return Intl.message(
      'Enter a valid email address',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password needs: uppercase, lowercase, number, symbol, min 6 chars.`
  String get enterValidPassword {
    return Intl.message(
      'Password needs: uppercase, lowercase, number, symbol, min 6 chars.',
      name: 'enterValidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number`
  String get mobileNumber {
    return Intl.message(
      'Mobile number',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your mobile number!`
  String get enterMobileNumber {
    return Intl.message(
      'Please enter your mobile number!',
      name: 'enterMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `By continuing, you agree to\n`
  String get byContinuing {
    return Intl.message(
      'By continuing, you agree to\n',
      name: 'byContinuing',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get termsOfUse {
    return Intl.message(
      'Terms of Use',
      name: 'termsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Please fill up the full form.`
  String get fillUpFullForm {
    return Intl.message(
      'Please fill up the full form.',
      name: 'fillUpFullForm',
      desc: '',
      args: [],
    );
  }

  /// `Weak password provided by the User.`
  String get weakPasswordMsg {
    return Intl.message(
      'Weak password provided by the User.',
      name: 'weakPasswordMsg',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email address.`
  String get checkEmailMsg {
    return Intl.message(
      'Please check your email address.',
      name: 'checkEmailMsg',
      desc: '',
      args: [],
    );
  }

  /// `User already exist for that`
  String get userExistMsg {
    return Intl.message(
      'User already exist for that',
      name: 'userExistMsg',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateProfile {
    return Intl.message(
      'Update Profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred while updating your profile`
  String get errorOccurredWhileUpdatingProfile {
    return Intl.message(
      'Error occurred while updating your profile',
      name: 'errorOccurredWhileUpdatingProfile',
      desc: '',
      args: [],
    );
  }

  /// `No data available.`
  String get noDataAvailable {
    return Intl.message(
      'No data available.',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `User {userName} updated successfully.`
  String userUpdatedSuccess(String userName) {
    return Intl.message(
      'User $userName updated successfully.',
      name: 'userUpdatedSuccess',
      desc: '',
      args: [userName],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Notification Setting`
  String get notificationSetting {
    return Intl.message(
      'Notification Setting',
      name: 'notificationSetting',
      desc: '',
      args: [],
    );
  }

  /// `Password Setting`
  String get passwordSetting {
    return Intl.message(
      'Password Setting',
      name: 'passwordSetting',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get deleteAccountMsg {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'deleteAccountMsg',
      desc: '',
      args: [],
    );
  }

  /// `Yes, delete`
  String get deleteConfirm {
    return Intl.message(
      'Yes, delete',
      name: 'deleteConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the code, sent to your email!`
  String get enterCodeSentToEmail {
    return Intl.message(
      'Please enter the code, sent to your email!',
      name: 'enterCodeSentToEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter code and both passwords.`
  String get enterCodeAndBothPasswords {
    return Intl.message(
      'Please enter code and both passwords.',
      name: 'enterCodeAndBothPasswords',
      desc: '',
      args: [],
    );
  }

  /// `Set Password`
  String get setPassword {
    return Intl.message(
      'Set Password',
      name: 'setPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password`
  String get createNewPassword {
    return Intl.message(
      'Create New Password',
      name: 'createNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `It's time to buy your favorite dish.`
  String get itsTimeToBuyFavoriteDish {
    return Intl.message(
      'It\'s time to buy your favorite dish.',
      name: 'itsTimeToBuyFavoriteDish',
      desc: '',
      args: [],
    );
  }

  /// `No user found for that {email}`
  String noUserFoundForEmail(String email) {
    return Intl.message(
      'No user found for that $email',
      name: 'noUserFoundForEmail',
      desc: '',
      args: [email],
    );
  }

  /// `Top Rated`
  String get topRated {
    return Intl.message(
      'Top Rated',
      name: 'topRated',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Help with the Order`
  String get helpWithTheOrder {
    return Intl.message(
      'Help with the Order',
      name: 'helpWithTheOrder',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Help center`
  String get helpCenter {
    return Intl.message(
      'Help center',
      name: 'helpCenter',
      desc: '',
      args: [],
    );
  }

  /// `General Information`
  String get generalInformation {
    return Intl.message(
      'General Information',
      name: 'generalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Hello!`
  String get hello {
    return Intl.message(
      'Hello!',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Order Management`
  String get orderManagement {
    return Intl.message(
      'Order Management',
      name: 'orderManagement',
      desc: '',
      args: [],
    );
  }

  /// `Payments Management`
  String get paymentsManagement {
    return Intl.message(
      'Payments Management',
      name: 'paymentsManagement',
      desc: '',
      args: [],
    );
  }

  /// `Account management and profile`
  String get accountManagementAndProfile {
    return Intl.message(
      'Account management and profile',
      name: 'accountManagementAndProfile',
      desc: '',
      args: [],
    );
  }

  /// `About order tracking`
  String get aboutOrderTracking {
    return Intl.message(
      'About order tracking',
      name: 'aboutOrderTracking',
      desc: '',
      args: [],
    );
  }

  /// `Safety`
  String get safety {
    return Intl.message(
      'Safety',
      name: 'safety',
      desc: '',
      args: [],
    );
  }

  /// `Order No.`
  String get orderNo {
    return Intl.message(
      'Order No.',
      name: 'orderNo',
      desc: '',
      args: [],
    );
  }

  /// `Order Issues`
  String get orderIssues {
    return Intl.message(
      'Order Issues',
      name: 'orderIssues',
      desc: '',
      args: [],
    );
  }

  /// `Order not received`
  String get orderNotReceived {
    return Intl.message(
      'Order not received',
      name: 'orderNotReceived',
      desc: '',
      args: [],
    );
  }

  /// `Write here...`
  String get writeHere {
    return Intl.message(
      'Write here...',
      name: 'writeHere',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `You have a current order Strawberry Shake and Broccoli Lasagna`
  String get aboutCurrentOrder {
    return Intl.message(
      'You have a current order Strawberry Shake and Broccoli Lasagna',
      name: 'aboutCurrentOrder',
      desc: '',
      args: [],
    );
  }

  /// `Hello!, please choose the number corresponding to your needs for a more efficient service.`
  String get helloPleaseChooseNumberCorresponding {
    return Intl.message(
      'Hello!, please choose the number corresponding to your needs for a more efficient service.',
      name: 'helloPleaseChooseNumberCorresponding',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get emptyCartMsg {
    return Intl.message(
      'Your cart is empty',
      name: 'emptyCartMsg',
      desc: '',
      args: [],
    );
  }

  /// `Want to add something?`
  String get addSomething {
    return Intl.message(
      'Want to add something?',
      name: 'addSomething',
      desc: '',
      args: [],
    );
  }

  /// `You have ${noOfCartItems} items in the cart`
  String noOfItemsInCart(int noOfCartItems) {
    return Intl.message(
      'You have \$$noOfCartItems items in the cart',
      name: 'noOfItemsInCart',
      desc: '',
      args: [noOfCartItems],
    );
  }

  /// `Checkout`
  String get checkOut {
    return Intl.message(
      'Checkout',
      name: 'checkOut',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message(
      'My Orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get areYouSureWantToLogout {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'areYouSureWantToLogout',
      desc: '',
      args: [],
    );
  }

  /// `Yes, logout`
  String get confirmLogout {
    return Intl.message(
      'Yes, logout',
      name: 'confirmLogout',
      desc: '',
      args: [],
    );
  }

  /// `Help and FAQs`
  String get helpAndFAQ {
    return Intl.message(
      'Help and FAQs',
      name: 'helpAndFAQ',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Payment Methods`
  String get paymentMethods {
    return Intl.message(
      'Payment Methods',
      name: 'paymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Bestseller`
  String get bestseller2 {
    return Intl.message(
      'Bestseller',
      name: 'bestseller2',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get recommended {
    return Intl.message(
      'Recommended',
      name: 'recommended',
      desc: '',
      args: [],
    );
  }

  /// `Leave A Review`
  String get leaveAReview {
    return Intl.message(
      'Leave A Review',
      name: 'leaveAReview',
      desc: '',
      args: [],
    );
  }

  /// `We'd love to know what you think of your dish.`
  String get weWouldLoveToKnow {
    return Intl.message(
      'We\'d love to know what you think of your dish.',
      name: 'weWouldLoveToKnow',
      desc: '',
      args: [],
    );
  }

  /// `Leave us your comment!`
  String get leaveUsComment {
    return Intl.message(
      'Leave us your comment!',
      name: 'leaveUsComment',
      desc: '',
      args: [],
    );
  }

  /// `Please review your order`
  String get pleaseReviewYourOrder {
    return Intl.message(
      'Please review your order',
      name: 'pleaseReviewYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Write Review...`
  String get writeReview {
    return Intl.message(
      'Write Review...',
      name: 'writeReview',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Order cancelled`
  String get orderCancelledTxt {
    return Intl.message(
      'Order cancelled',
      name: 'orderCancelledTxt',
      desc: '',
      args: [],
    );
  }

  /// `Order delivered`
  String get orderDelivered {
    return Intl.message(
      'Order delivered',
      name: 'orderDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter both email and password.`
  String get enterBothEmailAndPassword {
    return Intl.message(
      'Please enter both email and password.',
      name: 'enterBothEmailAndPassword',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password provided by the user.`
  String get wrongPasswordProvidedByTheUser {
    return Intl.message(
      'Wrong password provided by the user.',
      name: 'wrongPasswordProvidedByTheUser',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get doNotHaveAnAccount {
    return Intl.message(
      'Don’t have an account?',
      name: 'doNotHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any active orders at this time`
  String get noActiveOrdersThisTime {
    return Intl.message(
      'You don\'t have any active orders at this time',
      name: 'noActiveOrdersThisTime',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Order Again`
  String get orderAgain {
    return Intl.message(
      'Order Again',
      name: 'orderAgain',
      desc: '',
      args: [],
    );
  }

  /// `Order History`
  String get orderHistory {
    return Intl.message(
      'Order History',
      name: 'orderHistory',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Pay Now`
  String get payNow {
    return Intl.message(
      'Pay Now',
      name: 'payNow',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Time`
  String get deliveryTime {
    return Intl.message(
      'Delivery Time',
      name: 'deliveryTime',
      desc: '',
      args: [],
    );
  }

  /// `Estimated Delivery`
  String get estimatedDelivery {
    return Intl.message(
      'Estimated Delivery',
      name: 'estimatedDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Add New Card`
  String get addNewCard {
    return Intl.message(
      'Add New Card',
      name: 'addNewCard',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder Name`
  String get cardHolderName {
    return Intl.message(
      'Card Holder Name',
      name: 'cardHolderName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the card holder name`
  String get enterCardHolderName {
    return Intl.message(
      'Please enter the card holder name',
      name: 'enterCardHolderName',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get expiryDate {
    return Intl.message(
      'Expiry Date',
      name: 'expiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the expiry date`
  String get enterExpiryDate {
    return Intl.message(
      'Please enter the expiry date',
      name: 'enterExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get cardNumber {
    return Intl.message(
      'Card Number',
      name: 'cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the card number`
  String get enterCardNumber {
    return Intl.message(
      'Please enter the card number',
      name: 'enterCardNumber',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get cvv {
    return Intl.message(
      'CVV',
      name: 'cvv',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the CVV`
  String get enterCVV {
    return Intl.message(
      'Please enter the CVV',
      name: 'enterCVV',
      desc: '',
      args: [],
    );
  }

  /// `Add on ingredients`
  String get addOnIngredients {
    return Intl.message(
      'Add on ingredients',
      name: 'addOnIngredients',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message(
      'Add to Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `1`
  String get one {
    return Intl.message(
      '1',
      name: 'one',
      desc: '',
      args: [],
    );
  }

  /// `2`
  String get two {
    return Intl.message(
      '2',
      name: 'two',
      desc: '',
      args: [],
    );
  }

  /// `3`
  String get three {
    return Intl.message(
      '3',
      name: 'three',
      desc: '',
      args: [],
    );
  }

  /// `4`
  String get four {
    return Intl.message(
      '4',
      name: 'four',
      desc: '',
      args: [],
    );
  }

  /// `5`
  String get five {
    return Intl.message(
      '5',
      name: 'five',
      desc: '',
      args: [],
    );
  }

  /// `Recommendations`
  String get recommendations {
    return Intl.message(
      'Recommendations',
      name: 'recommendations',
      desc: '',
      args: [],
    );
  }

  /// `New Product`
  String get newProduct {
    return Intl.message(
      'New Product',
      name: 'newProduct',
      desc: '',
      args: [],
    );
  }

  /// `Discover the dishes recommended by the chef.`
  String get discoverTheDishesRecommended {
    return Intl.message(
      'Discover the dishes recommended by the chef.',
      name: 'discoverTheDishesRecommended',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Order Pending`
  String get orderPending {
    return Intl.message(
      'Order Pending',
      name: 'orderPending',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

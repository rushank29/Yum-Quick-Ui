// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(noOfCartItems) =>
      "You have \$${noOfCartItems} items in the cart";

  static String m1(email) => "No user found for that ${email}";

  static String m2(userName) => "User ${userName} updated successfully.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutCurrentOrder": MessageLookupByLibrary.simpleMessage(
            "You have a current order Strawberry Shake and Broccoli Lasagna"),
        "aboutOrderTracking":
            MessageLookupByLibrary.simpleMessage("About order tracking"),
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "accountManagementAndProfile": MessageLookupByLibrary.simpleMessage(
            "Account management and profile"),
        "active": MessageLookupByLibrary.simpleMessage("Active"),
        "addNewAddress":
            MessageLookupByLibrary.simpleMessage("Add New Address"),
        "addNewCard": MessageLookupByLibrary.simpleMessage("Add New Card"),
        "addOnIngredients":
            MessageLookupByLibrary.simpleMessage("Add on ingredients"),
        "addSomething":
            MessageLookupByLibrary.simpleMessage("Want to add something?"),
        "addToCart": MessageLookupByLibrary.simpleMessage("Add to Cart"),
        "address": MessageLookupByLibrary.simpleMessage("Address"),
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "and": MessageLookupByLibrary.simpleMessage("and"),
        "apply": MessageLookupByLibrary.simpleMessage("Apply"),
        "areYouSureWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to log out?"),
        "backOnline":
            MessageLookupByLibrary.simpleMessage("You’re back online"),
        "bestSeller": MessageLookupByLibrary.simpleMessage("Best Seller"),
        "bestseller2": MessageLookupByLibrary.simpleMessage("Bestseller"),
        "byContinuing": MessageLookupByLibrary.simpleMessage(
            "By continuing, you agree to\n"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cancelOrder": MessageLookupByLibrary.simpleMessage("Cancel Order"),
        "cancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
        "cardHolderName":
            MessageLookupByLibrary.simpleMessage("Card Holder Name"),
        "cardNumber": MessageLookupByLibrary.simpleMessage("Card Number"),
        "cart": MessageLookupByLibrary.simpleMessage("Cart"),
        "categories": MessageLookupByLibrary.simpleMessage("Categories"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Change Password"),
        "checkEmailMsg": MessageLookupByLibrary.simpleMessage(
            "Please check your email address."),
        "checkOut": MessageLookupByLibrary.simpleMessage("Checkout"),
        "code": MessageLookupByLibrary.simpleMessage("Code"),
        "completed": MessageLookupByLibrary.simpleMessage("Completed"),
        "confirmLogout": MessageLookupByLibrary.simpleMessage("Yes, logout"),
        "confirmOrder": MessageLookupByLibrary.simpleMessage("Confirm Order"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Contact Us"),
        "continueTxt": MessageLookupByLibrary.simpleMessage("Continue"),
        "createNewPassword":
            MessageLookupByLibrary.simpleMessage("Create New Password"),
        "cvv": MessageLookupByLibrary.simpleMessage("CVV"),
        "dateOfBirth": MessageLookupByLibrary.simpleMessage("Date of birth"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete Account"),
        "deleteAccountMsg": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete your account?"),
        "deleteConfirm": MessageLookupByLibrary.simpleMessage("Yes, delete"),
        "delivery": MessageLookupByLibrary.simpleMessage("Delivery"),
        "deliveryAddress":
            MessageLookupByLibrary.simpleMessage("Delivery Address"),
        "deliveryBy": MessageLookupByLibrary.simpleMessage("Delivery by"),
        "deliveryTime": MessageLookupByLibrary.simpleMessage("Delivery Time"),
        "details": MessageLookupByLibrary.simpleMessage("Details"),
        "discoverPopularDishes": MessageLookupByLibrary.simpleMessage(
            "Discover our most popular dishes!"),
        "discoverTheDishesRecommended": MessageLookupByLibrary.simpleMessage(
            "Discover the dishes recommended by the chef."),
        "doNotHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Don’t have an account?"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emptyCartMsg":
            MessageLookupByLibrary.simpleMessage("Your cart is empty"),
        "enterAddressName": MessageLookupByLibrary.simpleMessage(
            "Please enter the address name"),
        "enterBothEmailAndPassword": MessageLookupByLibrary.simpleMessage(
            "Please enter both email and password."),
        "enterCVV":
            MessageLookupByLibrary.simpleMessage("Please enter the CVV"),
        "enterCardHolderName": MessageLookupByLibrary.simpleMessage(
            "Please enter the card holder name"),
        "enterCardNumber": MessageLookupByLibrary.simpleMessage(
            "Please enter the card number"),
        "enterCodeAndBothPasswords": MessageLookupByLibrary.simpleMessage(
            "Please enter code and both passwords."),
        "enterCodeSentToEmail": MessageLookupByLibrary.simpleMessage(
            "Please enter the code, sent to your email!"),
        "enterExpiryDate": MessageLookupByLibrary.simpleMessage(
            "Please enter the expiry date"),
        "enterFullAddressInDescriptive": MessageLookupByLibrary.simpleMessage(
            "Please enter the full address in descriptive form!"),
        "enterMobileNumber": MessageLookupByLibrary.simpleMessage(
            "Please enter your mobile number!"),
        "enterValidEmail":
            MessageLookupByLibrary.simpleMessage("Enter a valid email address"),
        "enterValidPassword": MessageLookupByLibrary.simpleMessage(
            "Password needs: uppercase, lowercase, number, symbol, min 6 chars."),
        "enterYourName":
            MessageLookupByLibrary.simpleMessage("Please enter your name."),
        "errorOccurredWhileUpdatingProfile":
            MessageLookupByLibrary.simpleMessage(
                "Error occurred while updating your profile"),
        "estimatedDelivery":
            MessageLookupByLibrary.simpleMessage("Estimated Delivery"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "faq": MessageLookupByLibrary.simpleMessage("faq"),
        "favorites": MessageLookupByLibrary.simpleMessage("Favorites"),
        "fillUpFullForm": MessageLookupByLibrary.simpleMessage(
            "Please fill up the full form."),
        "filter": MessageLookupByLibrary.simpleMessage("Filter"),
        "five": MessageLookupByLibrary.simpleMessage("5"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "four": MessageLookupByLibrary.simpleMessage("4"),
        "fullName": MessageLookupByLibrary.simpleMessage("Full name"),
        "general": MessageLookupByLibrary.simpleMessage("General"),
        "generalInformation":
            MessageLookupByLibrary.simpleMessage("General Information"),
        "getStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
        "hello": MessageLookupByLibrary.simpleMessage("Hello!"),
        "helloPleaseChooseNumberCorresponding":
            MessageLookupByLibrary.simpleMessage(
                "Hello!, please choose the number corresponding to your needs for a more efficient service."),
        "help": MessageLookupByLibrary.simpleMessage("Help"),
        "helpAndFAQ": MessageLookupByLibrary.simpleMessage("Help and FAQs"),
        "helpCenter": MessageLookupByLibrary.simpleMessage("Help center"),
        "helpWithTheOrder":
            MessageLookupByLibrary.simpleMessage("Help with the Order"),
        "ifQuestionsReachSupport": MessageLookupByLibrary.simpleMessage(
            "If you have any question reach directly to our customer support"),
        "items": MessageLookupByLibrary.simpleMessage("items"),
        "itsTimeToBuyFavoriteDish": MessageLookupByLibrary.simpleMessage(
            "It\'s time to buy your favorite dish."),
        "leaveAReview": MessageLookupByLibrary.simpleMessage("Leave A Review"),
        "leaveUsComment":
            MessageLookupByLibrary.simpleMessage("Leave us your comment!"),
        "logIn": MessageLookupByLibrary.simpleMessage("Log In"),
        "logOut": MessageLookupByLibrary.simpleMessage("Log out"),
        "loremIpsum": MessageLookupByLibrary.simpleMessage(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        "mobileNumber": MessageLookupByLibrary.simpleMessage("Mobile number"),
        "myOrders": MessageLookupByLibrary.simpleMessage("My Orders"),
        "myProfile": MessageLookupByLibrary.simpleMessage("My Profile"),
        "newAccount": MessageLookupByLibrary.simpleMessage("New Account"),
        "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
        "newProduct": MessageLookupByLibrary.simpleMessage("New Product"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "noActiveOrdersThisTime": MessageLookupByLibrary.simpleMessage(
            "You don\'t have any active orders at this time"),
        "noAddressFoundInPref": MessageLookupByLibrary.simpleMessage(
            "No address found in prefs or delivery list not ready."),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available."),
        "noDeliveryAddressSet": MessageLookupByLibrary.simpleMessage(
            "You don\'t have any delivery addresses set, currently."),
        "noOfItemsInCart": m0,
        "noUserFoundForEmail": m1,
        "notificationSetting":
            MessageLookupByLibrary.simpleMessage("Notification Setting"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "offlineTryingToReconnect": MessageLookupByLibrary.simpleMessage(
            "You\'re offline. Trying to reconnect..."),
        "oldPassword": MessageLookupByLibrary.simpleMessage("Old Password"),
        "one": MessageLookupByLibrary.simpleMessage("1"),
        "or": MessageLookupByLibrary.simpleMessage("Or"),
        "orderAgain": MessageLookupByLibrary.simpleMessage("Order Again"),
        "orderCancelled":
            MessageLookupByLibrary.simpleMessage("¡Order Cancelled!"),
        "orderCancelledTxt":
            MessageLookupByLibrary.simpleMessage("Order cancelled"),
        "orderConfirmed":
            MessageLookupByLibrary.simpleMessage("¡Order Confirmed!"),
        "orderDelivered":
            MessageLookupByLibrary.simpleMessage("Order delivered"),
        "orderDetails": MessageLookupByLibrary.simpleMessage("Order Details"),
        "orderHistory": MessageLookupByLibrary.simpleMessage("Order History"),
        "orderIssues": MessageLookupByLibrary.simpleMessage("Order Issues"),
        "orderManagement":
            MessageLookupByLibrary.simpleMessage("Order Management"),
        "orderNo": MessageLookupByLibrary.simpleMessage("Order No."),
        "orderNotReceived":
            MessageLookupByLibrary.simpleMessage("Order not received"),
        "orderPending": MessageLookupByLibrary.simpleMessage("Order Pending"),
        "orderPlacedSuccessful": MessageLookupByLibrary.simpleMessage(
            "Your order has been placed successfully"),
        "orderSuccessfullyCancelled": MessageLookupByLibrary.simpleMessage(
            "Your order has been successfully cancelled"),
        "orderSummary": MessageLookupByLibrary.simpleMessage("Order Summary"),
        "otherReasons":
            MessageLookupByLibrary.simpleMessage("Other reasons..."),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordSetting":
            MessageLookupByLibrary.simpleMessage("Password Setting"),
        "payNow": MessageLookupByLibrary.simpleMessage("Pay Now"),
        "payment": MessageLookupByLibrary.simpleMessage("Payment"),
        "paymentMethods":
            MessageLookupByLibrary.simpleMessage("Payment Methods"),
        "paymentsManagement":
            MessageLookupByLibrary.simpleMessage("Payments Management"),
        "placeOrder": MessageLookupByLibrary.simpleMessage("Place Order"),
        "pleaseReviewYourOrder":
            MessageLookupByLibrary.simpleMessage("Please review your order"),
        "popular": MessageLookupByLibrary.simpleMessage("Popular"),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "recommendations":
            MessageLookupByLibrary.simpleMessage("Recommendations"),
        "recommended": MessageLookupByLibrary.simpleMessage("Recommended"),
        "safety": MessageLookupByLibrary.simpleMessage("Safety"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "selectDateOfBirth": MessageLookupByLibrary.simpleMessage(
            "Please select your birth date!"),
        "selectLanguage":
            MessageLookupByLibrary.simpleMessage("Select Language"),
        "selectOrEnterCancellationReason": MessageLookupByLibrary.simpleMessage(
            "Please select the cancellation reason or enter the one!"),
        "services": MessageLookupByLibrary.simpleMessage("Services"),
        "setPassword": MessageLookupByLibrary.simpleMessage("Set Password"),
        "setYourFingerPrint":
            MessageLookupByLibrary.simpleMessage("Set Your Fingerprint"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "shippingAddress":
            MessageLookupByLibrary.simpleMessage("Shipping Address"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort By"),
        "subTotal": MessageLookupByLibrary.simpleMessage("Subtotal"),
        "submit": MessageLookupByLibrary.simpleMessage("Submit"),
        "support": MessageLookupByLibrary.simpleMessage("Support"),
        "taxAndFees": MessageLookupByLibrary.simpleMessage("Tax and Fees"),
        "termsOfUse": MessageLookupByLibrary.simpleMessage("Terms of Use"),
        "three": MessageLookupByLibrary.simpleMessage("3"),
        "topRated": MessageLookupByLibrary.simpleMessage("Top Rated"),
        "total": MessageLookupByLibrary.simpleMessage("Total"),
        "trackMyOrder": MessageLookupByLibrary.simpleMessage("Track my order"),
        "two": MessageLookupByLibrary.simpleMessage("2"),
        "updateProfile": MessageLookupByLibrary.simpleMessage("Update Profile"),
        "userExistMsg":
            MessageLookupByLibrary.simpleMessage("User already exist for that"),
        "userUpdatedSuccess": m2,
        "viewAll": MessageLookupByLibrary.simpleMessage("View All"),
        "weWouldLoveToKnow": MessageLookupByLibrary.simpleMessage(
            "We\'d love to know what you think of your dish."),
        "weakPasswordMsg": MessageLookupByLibrary.simpleMessage(
            "Weak password provided by the User."),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome"),
        "writeHere": MessageLookupByLibrary.simpleMessage("Write here..."),
        "writeReview": MessageLookupByLibrary.simpleMessage("Write Review..."),
        "wrongPasswordProvidedByTheUser": MessageLookupByLibrary.simpleMessage(
            "Wrong password provided by the user.")
      };
}

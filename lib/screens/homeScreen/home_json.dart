import 'package:flutter/material.dart';

DateTime now = DateTime.now();
TimeOfDay morning5Time = const TimeOfDay(hour: 5, minute: 0);
TimeOfDay noon12Time = const TimeOfDay(hour: 12, minute: 0);
TimeOfDay evening5Time = const TimeOfDay(hour: 17, minute: 0);
TimeOfDay night9Time = const TimeOfDay(hour: 21, minute: 0);

TimeOfDay currentTime = TimeOfDay.fromDateTime(now);

String greetingMessage1 = "";
String greetingMessage2 = "";

void setGettingMessage() {
  if (currentTime.hour > morning5Time.hour && currentTime.hour < noon12Time.hour) {
    greetingMessage1 = "Good morning";
    greetingMessage2 = "Rise and shine! It's breakfast time.";
  } else if (currentTime.hour > noon12Time.hour && currentTime.hour < evening5Time.hour) {
    greetingMessage1 = "Good Afternoon";
    greetingMessage2 = "Midday hunger? Let’s fix that!";
  } else if (currentTime.hour > evening5Time.hour && currentTime.hour < night9Time.hour) {
    greetingMessage1 = "Good Evening";
    greetingMessage2 = "Evenings are better with your favorite meal!";
  } else {
    greetingMessage1 = "Good Night";
    greetingMessage2 = "Late night bites, just a tap away!";
  }
}

Map<String, dynamic> homeJson = {
  "greeting_message_main": greetingMessage1,
  "greeting_message_sub": greetingMessage2,
  "food_categories": [
    {
      "category_id": 1,
      "category_name": "Snacks",
      "category_icon": "assets/svg/snacks.svg",
    },
    {
      "category_id": 2,
      "category_name": "Meal",
      "category_icon": "assets/svg/meals.svg",
    },
    {
      "category_id": 3,
      "category_name": "Vegan",
      "category_icon": "assets/svg/vegan.svg",
    },
    {
      "category_id": 4,
      "category_name": "Dessert",
      "category_icon": "assets/svg/desserts.svg",
    },
    {
      "category_id": 5,
      "category_name": "Drinks",
      "category_icon": "assets/svg/drinks.svg",
    },
  ],
  "best_seller_food_items": [
    {
      "item_id": 1,
      "item_name": "Sushi",
      "item_image": "assets/images/bestseller1.png",
      "item_price": 103,
    },
    {
      "item_id": 2,
      "item_name": "Paneer Makhani & Rice",
      "item_image": "assets/images/bestseller2.png",
      "item_price": 50,
    },
    {
      "item_id": 3,
      "item_name": "Lasagna",
      "item_image": "assets/images/bestseller3.png",
      "item_price": 12.99,
    },
    {
      "item_id": 4,
      "item_name": "Berry cup-cake",
      "item_image": "assets/images/bestseller4.png",
      "item_price": 8.20,
    },
  ],
  "home_page_slider": [
    {
      "slider_id": 1,
      "slider_image": "assets/images/home_page_slider.png",
      "slider_msg1": "Experience our delicious new dish",
      "slider_msg2": "30% OFF",
    },
    {
      "slider_id": 2,
      "slider_image": "assets/images/home_page_slider.png",
      "slider_msg1": "Experience our delicious new dish",
      "slider_msg2": "30% OFF",
    },
    {
      "slider_id": 3,
      "slider_image": "assets/images/home_page_slider.png",
      "slider_msg1": "Experience our delicious new dish",
      "slider_msg2": "30% OFF",
    },
    {
      "slider_id": 4,
      "slider_image": "assets/images/home_page_slider.png",
      "slider_msg1": "Experience our delicious new dish",
      "slider_msg2": "30% OFF",
    },
    {
      "slider_id": 5,
      "slider_image": "assets/images/home_page_slider.png",
      "slider_msg1": "Experience our delicious new dish",
      "slider_msg2": "30% OFF",
    },
  ],
  "recommended_food_items": [
    {
      "item_id": 1,
      "item_name": "Cheesy Mexican Burger",
      "item_image": "assets/images/home_burger.png",
      "item_price": 13.89,
      "item_rating": 4.75,
    },
    {
      "item_id": 2,
      "item_name": "Vietnamese Spring Roll",
      "item_image": "assets/images/home_spring_roll.png",
      "item_price": 18.79,
      "item_rating": 4.27,
    },
    {
      "item_id": 3,
      "item_name": "Chinese Spring Roll",
      "item_image": "assets/images/home_spring_roll.png",
      "item_price": 12.39,
      "item_rating": 3.97,
    },
    {
      "item_id": 4,
      "item_name": "Cheesy Aloo Tikki Burger",
      "item_image": "assets/images/home_burger.png",
      "item_price": 10,
      "item_rating": 4,
    },
  ],
};

import 'package:flutter/material.dart';

DateTime now = DateTime.now();
TimeOfDay morning5Time = const TimeOfDay(hour: 5, minute: 0);
TimeOfDay noon12Time = const TimeOfDay(hour: 12, minute: 0);
TimeOfDay evening5Time = const TimeOfDay(hour: 17, minute: 0);
TimeOfDay night9Time = const TimeOfDay(hour: 21, minute: 0);

TimeOfDay currentTime = TimeOfDay.fromDateTime(now);

String greetingMessage1 = "";
String greetingMessage2 = "";

void setGreetingMessage() {
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
      "top_rated": 4,
      "sub_categories": [
        {"id": 1, "name": "Bruschetta"},
        {"id": 2, "name": "Spring Rolls"},
        {"id": 3, "name": "Crepes"},
        {"id": 4, "name": "Wings"},
        {"id": 5, "name": "Skewers"},
        {"id": 6, "name": "Salmon"},
        {"id": 7, "name": "Mexican"},
        {"id": 8, "name": "Baked"},
        {"id": 9, "name": "Appetizer"}
      ],
      "selected_price": 10
    },
    {
      "category_id": 2,
      "category_name": "Meal",
      "category_icon": "assets/svg/meals.svg",
      "top_rated": 2,
      "sub_categories": [
        {"id": 1, "name": "Sushi"},
        {"id": 2, "name": "Pizza"},
        {"id": 3, "name": "Chicken"},
        {"id": 4, "name": "Curry"},
        {"id": 5, "name": "Burger"},
        {"id": 6, "name": "Cheese"},
        {"id": 7, "name": "Fresh Prawn"},
        {"id": 8, "name": "Ceviche"},
        {"id": 9, "name": "Pad Thai"}
      ],
      "selected_price": 50
    },
    {
      "category_id": 3,
      "category_name": "Vegan",
      "category_icon": "assets/svg/vegan.svg",
      "top_rated": 4,
      "sub_categories": [
        {"id": 1, "name": "Bean Burger"},
        {"id": 2, "name": "Lasagna"},
        {"id": 3, "name": "Pizza"},
        {"id": 4, "name": "Mushroom"},
        {"id": 5, "name": "Risotto"},
        {"id": 6, "name": "Brocolli"},
        {"id": 7, "name": "Hummus"},
        {"id": 8, "name": "Quinoa"},
        {"id": 9, "name": "Salad"}
      ],
      "selected_price": 10
    },
    {
      "category_id": 4,
      "category_name": "Dessert",
      "category_icon": "assets/svg/desserts.svg",
      "top_rated": 3,
      "sub_categories": [
        {"id": 1, "name": "Crepes"},
        {"id": 2, "name": "Macarons"},
        {"id": 3, "name": "Cupcakes"},
        {"id": 4, "name": "Ice cream"},
        {"id": 5, "name": "Flan"},
        {"id": 6, "name": "Cheesecake"},
        {"id": 7, "name": "Chocolate"},
        {"id": 8, "name": "Cakes"},
        {"id": 9, "name": "Brownie"}
      ],
      "selected_price": 50
    },
    {
      "category_id": 5,
      "category_name": "Drinks",
      "category_icon": "assets/svg/drinks.svg",
      "top_rated": 5,
      "sub_categories": [
        {"id": 1, "name": "Coffee"},
        {"id": 2, "name": "Cocktail"},
        {"id": 3, "name": "Juice"},
        {"id": 4, "name": "Milkshake"},
        {"id": 5, "name": "Wine"},
        {"id": 6, "name": "Piña Colada"},
        {"id": 7, "name": "Mojito"},
        {"id": 8, "name": "Craft Beer"},
        {"id": 9, "name": "Ice Tea"}
      ],
      "selected_price": 100
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
      "product_item": [
        {
          "dish_image": "assets/images/pizza.png",
          "dish_name": "Pizza with Pepperoni and Cheese",
          "short_description":
          "Pizza, made from a fresh dough, a gritted cheese, with a taste of pepperoni.",
          "dish_rating": 14.0,
          "dish_price": 14.0,
          "dish_full_price": 20.0,
          "is_favorite": 1,
          "full_description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
          "topping_list": [
            {"id": 1, "price": 0.0, "name": "Personal (4 Slides)"},
            {"id": 2, "price": 3.0, "name": "Medium (8 Slides)"},
            {"id": 3, "price": 6.0, "name": "Familiar (10 Slides)"},
            {"id": 4, "price": 10.0, "name": "Jumbo (12 Slides)"}
          ]
        }
      ]
    },
    {
      "slider_id": 2,
      "slider_image": "assets/images/home_page_slider.png",
      "slider_msg1": "Experience our delicious new dish",
      "slider_msg2": "30% OFF",
      "product_item": [
        {
          "dish_image": "assets/images/pizza.png",
          "dish_name": "Pizza with Pepperoni and Cheese",
          "short_description":
          "Pizza, made from a fresh dough, a gritted cheese, with a taste of pepperoni.",
          "dish_rating": 14.0,
          "dish_price": 14.0,
          "dish_full_price": 20.0,
          "is_favorite": 0,
          "full_description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
          "topping_list": [
            {"id": 1, "price": 0.0, "name": "Personal (4 Slides)"},
            {"id": 2, "price": 3.0, "name": "Medium (8 Slides)"},
            {"id": 3, "price": 6.0, "name": "Familiar (10 Slides)"},
            {"id": 4, "price": 10.0, "name": "Jumbo (12 Slides)"}
          ]
        }
      ]
    },
    {
      "slider_id": 3,
      "slider_image": "assets/images/home_page_slider.png",
      "slider_msg1": "Experience our delicious new dish",
      "slider_msg2": "30% OFF",
      "product_item": [
        {
          "dish_image": "assets/images/pizza.png",
          "dish_name": "Pizza with Pepperoni and Cheese",
          "short_description":
          "Pizza, made from a fresh dough, a gritted cheese, with a taste of pepperoni.",
          "dish_rating": 14.0,
          "dish_price": 14.0,
          "dish_full_price": 20.0,
          "is_favorite": 0,
          "full_description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
          "topping_list": [
            {"id": 1, "price": 0.0, "name": "Personal (4 Slides)"},
            {"id": 2, "price": 3.0, "name": "Medium (8 Slides)"},
            {"id": 3, "price": 6.0, "name": "Familiar (10 Slides)"},
            {"id": 4, "price": 10.0, "name": "Jumbo (12 Slides)"}
          ]
        }
      ]
    },
    {
      "slider_id": 4,
      "slider_image": "assets/images/home_page_slider.png",
      "slider_msg1": "Experience our delicious new dish",
      "slider_msg2": "30% OFF",
      "product_item": [
        {
          "dish_image": "assets/images/pizza.png",
          "dish_name": "Pizza with Pepperoni and Cheese",
          "short_description":
          "Pizza, made from a fresh dough, a gritted cheese, with a taste of pepperoni.",
          "dish_rating": 14.0,
          "dish_price": 14.0,
          "dish_full_price": 20.0,
          "is_favorite": 1,
          "full_description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
          "topping_list": [
            {"id": 1, "price": 0.0, "name": "Personal (4 Slides)"},
            {"id": 2, "price": 3.0, "name": "Medium (8 Slides)"},
            {"id": 3, "price": 6.0, "name": "Familiar (10 Slides)"},
            {"id": 4, "price": 10.0, "name": "Jumbo (12 Slides)"}
          ]
        }
      ]
    },
    {
      "slider_id": 5,
      "slider_image": "assets/images/home_page_slider.png",
      "slider_msg1": "Experience our delicious new dish",
      "slider_msg2": "30% OFF",
      "product_item": [
        {
          "dish_image": "assets/images/pizza.png",
          "dish_name": "Pizza with Pepperoni and Cheese",
          "short_description":
          "Pizza, made from a fresh dough, a gritted cheese, with a taste of pepperoni.",
          "dish_rating": 14.0,
          "dish_price": 14.0,
          "dish_full_price": 20.0,
          "is_favorite": 0,
          "full_description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
          "topping_list": [
            {"id": 1, "price": 0.0, "name": "Personal (4 Slides)"},
            {"id": 2, "price": 3.0, "name": "Medium (8 Slides)"},
            {"id": 3, "price": 6.0, "name": "Familiar (10 Slides)"},
            {"id": 4, "price": 10.0, "name": "Jumbo (12 Slides)"}
          ]
        }
      ]
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

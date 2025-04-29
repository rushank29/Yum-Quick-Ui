Map<String, dynamic> myOrdersJson(int orderStatus) {
  return {
    "order_history": switch (orderStatus) {
      0 => [
          {
            "item_image": "assets/images/strawberry_shake.png",
            "item_name": "Strawberry shake",
            "order_amount": 20.00,
            "order_date_time": "29-11-2024, 13:20",
            "order_item_count": 2
          }
        ],
      1 => [
          {
            "item_image": "assets/images/bestseller2.png",
            "item_name": "Chicken Curry",
            "order_amount": 50.00,
            "order_date_time": "29-11-2024, 13:20",
            "order_item_count": 2
          },
          {
            "item_image": "assets/images/home_burger.png",
            "item_name": "Bean and Vegetable Burger",
            "order_amount": 50.00,
            "order_date_time": "10-11-2024, 18:05",
            "order_item_count": 2
          },
          {
            "item_image": "assets/images/coffee_latte.png",
            "item_name": "Bean and Vegetable Burger",
            "order_amount": 8.00,
            "order_date_time": "10-11-2024, 08:30",
            "order_item_count": 1
          },
          {
            "item_image": "assets/images/strawberry_cheesecake.png",
            "item_name": "Bean and Vegetable Burger",
            "order_amount": 22.00,
            "order_date_time": "03-10-2024, 15:40",
            "order_item_count": 2
          }
        ],
      2 => [
          {
            "item_image": "assets/images/bestseller1.png",
            "item_name": "Sushi Wave",
            "order_amount": 103.00,
            "order_date_time": "02-11-2024, 16:00",
            "order_item_count": 3
          },
          {
            "item_image": "assets/images/fruit_and_berry_tea.png",
            "item_name": "Fruit and Berry Tea",
            "order_amount": 15.00,
            "order_date_time": "12-10-2024, 16:00",
            "order_item_count": 2
          }
        ],
      _ => [
          {
            "item_image": "assets/images/strawberry_shake.png",
            "item_name": "Strawberry shake",
            "order_amount": 20.00,
            "order_date_time": "29-11-2024, 13:20",
            "order_item_count": 2
          }
        ]
    },
  };
}

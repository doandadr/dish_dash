import 'dart:convert';

class Restaurant {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menu menus;
  num rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        city: restaurant['city'],
        address: restaurant['address'],
        pictureId: restaurant['pictureId'],
        categories: (restaurant['categories'] as List).map((json) => Category.fromJson(json)).toList(),
        menus: Menu.fromJson(restaurant['menus']),
        rating: restaurant['rating'],
      );
}

class Menu {
  List<Food> foods;
  List<Drink> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> menu) => Menu(
    foods: (menu['foods'] as List).map((json) => Food.fromJson(json)).toList(),
    drinks: (menu['drinks'] as List).map((json) => Drink.fromJson(json)).toList(),
  );
}

class Drink {
  String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> drink) => Drink(
      name: drink['name']
  );
}

class Food {
  String name;

  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> food) => Food(
      name: food['name']
  );
}

class Category {
  String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> category) => Category(
    name: category['name'],
  );
}

// To parse this JSON data, do
//
//     final restaurantListResult = restaurantListResultFromJson(jsonString);

import 'dart:convert';

import 'package:dish_dash/data/model/restaurant.dart';

RestaurantListResult restaurantListResultFromJson(String str) => RestaurantListResult.fromJson(json.decode(str));

String restaurantListResultToJson(RestaurantListResult data) => json.encode(data.toJson());

class RestaurantListResult {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestaurantListResult({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResult.fromJson(Map<String, dynamic> json) => RestaurantListResult(
    error: json["error"],
    message: json["message"],
    count: json["count"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}
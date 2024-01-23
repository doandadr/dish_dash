import 'dart:convert';

import 'package:dish_dash/data/model/restaurant_detail_result.dart';
import 'package:dish_dash/data/model/restaurant_list_result.dart';
import 'package:dish_dash/data/model/restaurant_search_result.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<RestaurantListResult> getRestaurantList() async {
    final response = await http.get(Uri.parse(
        "${_baseUrl}list"
    ));
    if (response.statusCode == 200) {
      return RestaurantListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load list of restaurants");
    }
  }

  Future<RestaurantDetailResult> getRestaurantDetails(String restaurantId) async {
    final response = await http.get(Uri.parse(
      "${_baseUrl}detail/$restaurantId"
    ));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load restaurant details");
    }
  }

  Future<RestaurantSearchResult> searchRestaurants(String query) async {
    final response = await http.get(Uri.parse(
      "${_baseUrl}search?q=$query"
    ));
    if (response.statusCode == 200) {
      return RestaurantSearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load searched restaurants");
    }
  }
}
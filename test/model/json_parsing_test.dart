import 'dart:convert';
import 'dart:io';
import 'package:dish_dash/data/model/restaurant_detail_result.dart';
import 'package:dish_dash/data/model/restaurant_list_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JSON parsing test', () {
    test('Parse restaurant list json return correct model', () async {
      final testRestaurantListResult =
          File('test/model/test_data/restaurant_list_result.json').readAsStringSync();
      final restaurantListResult = RestaurantListResult.fromJson(
          jsonDecode(testRestaurantListResult) as Map<String, dynamic>);

      expect(restaurantListResult.error, false);
      expect(restaurantListResult.message, "success");
      expect(restaurantListResult.restaurants.length, 1);
      expect(restaurantListResult.restaurants[0].name, "Melting Pot");
    });

    test('Parse restaurant details json return correct model', () async {
      final testRestaurantDetailsResult =
      File('test/model/test_data/restaurant_details_result.json').readAsStringSync();
      final restaurantDetailsResult = RestaurantDetailResult.fromJson(
          jsonDecode(testRestaurantDetailsResult) as Map<String, dynamic>);

      expect(restaurantDetailsResult.error, false);
      expect(restaurantDetailsResult.message, "success");
      expect(restaurantDetailsResult.restaurant.name, "Melting Pot");
      expect(restaurantDetailsResult.restaurant.rating, 4.2);
      expect(restaurantDetailsResult.restaurant.categories[0].name, "Italia");
      expect(restaurantDetailsResult.restaurant.menus.foods[0].name, "Paket rosemary");
    });
  });
}

import 'dart:convert';

import 'package:dish_dash/common/style.dart';
import 'package:dish_dash/data/api/api_service.dart';
import 'package:dish_dash/data/model/restaurant.dart';
import 'package:dish_dash/provider/restaurant_list_provider.dart';
import 'package:dish_dash/widget/card_restaurant.dart';
import 'package:dish_dash/widget/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantListPage extends StatelessWidget {
  static const String restaurantListTitle = 'Restaurants';

  const RestaurantListPage({
    super.key,
  });

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        final List<Restaurant> restaurants = _parseRestaurants(snapshot.data);
        return ListView.separated(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = restaurants[index];
            return CardRestaurant(restaurant: restaurant);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 1,
            );
          },
        );
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurants',
          style: TextStyle(color: primaryColor, fontFamily: 'Hero'),
        ),
        elevation: 6,
        shadowColor: Colors.black,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        leading: const Icon(
          Icons.fastfood,
          color: primaryColor,
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        leading: Icon(
          CupertinoIcons.house_fill,
          color: primaryColor,
        ),
        middle: Text(
        'Restaurants',
        style: TextStyle(color: primaryColor, fontFamily: 'Hero'),
      ),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (_) {
        return RestaurantListProvider(apiService: ApiService());
      },
      child: PlatformWidget(
          androidBuilder: _buildAndroid, iosBuilder: _buildIos),
    );
  }

  List<Restaurant> _parseRestaurants(String? json) {
    if (json == null) return [];

    final List parsed = jsonDecode(json);
    return parsed.map((json) => Restaurant.fromJson(json)).toList();
  }
}

import 'dart:convert';

import 'package:dish_dash/model/restaurant.dart';
import 'package:dish_dash/style.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Browse Restaurants',
            style: TextStyle(color: primaryColor),
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
        body: SafeArea(
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/restaurants.json'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              final List<Restaurant> restaurants =
                  parseRestaurants(snapshot.data);
              return ListView.separated(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantItem(context, restaurants[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 1,
                  );
                },
              );
            },
          ),
        ));
  }

  List<Restaurant> parseRestaurants(String? json) {
    if (json == null) return [];

    final List parsed = jsonDecode(json);
    return parsed.map((json) => Restaurant.fromJson(json)).toList();
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  height: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                      fit: BoxFit.cover,

                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        color: secondaryColor,
                        size: 16,
                      ),
                      Text(restaurant.rating.toStringAsPrecision(2))
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Hero',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  restaurant.categories.map((c) => c.name).join(", "),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: primaryColor,
                    ),
                    Text(restaurant.city),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

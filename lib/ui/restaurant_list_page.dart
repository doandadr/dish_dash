import 'package:dish_dash/common/style.dart';
import 'package:dish_dash/data/api/api_service.dart';
import 'package:dish_dash/provider/restaurant_list_provider.dart';
import 'package:dish_dash/widget/card_restaurant.dart';
import 'package:dish_dash/widget/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/result_state.dart';

class RestaurantListPage extends StatelessWidget {
  static const String restaurantListTitle = 'Restaurants';

  const RestaurantListPage({
    super.key,
  });

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantListProvider>(builder: (context, provider, _) {
      if (provider.state == ResultState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (provider.state == ResultState.hasData) {
          return ListView.separated(
            itemCount: provider.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = provider.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 1,
              );
            },
          );
        } else if (provider.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(provider.message),
            ),
          );
        } else if (provider.state == ResultState.error) {
          return const Center (
            child: Material(
              child: Text("Error: Could not retrieve data from network"),
            ),
          );
        }else {
          return const Material(
            child: Text(''),
          );
        }
      }
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Browse Restaurants',
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
          'Browse Restaurants',
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
      child:
          PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos),
    );
  }
}

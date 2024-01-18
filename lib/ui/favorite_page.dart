import 'package:dish_dash/provider/database_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/style.dart';
import '../utils/result_state.dart';
import '../widget/card_restaurant.dart';
import '../widget/platform_widget.dart';

class FavoritePage extends StatelessWidget {
  static const String favoriteTitle = 'Favorites';

  const FavoritePage({super.key});

  Widget _buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, _) {
      switch (provider.state) {
        case ResultState.loading:
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));

        case ResultState.hasData:
          return ListView.separated(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              var restaurant = provider.favorites[index];
              return CardRestaurant(restaurant: restaurant);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 1,
              );
            },
          );
        case ResultState.noData:
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Material(
                child: Text("Your favorite restaurants will be shown here", textAlign: TextAlign.center,),
              ),
            ),
          );
        case ResultState.error:
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: const Material(
              child: Text("Error: Could not retrieve data from local"),
            ),
          );
        default:
          return const Material(
            child: Text(''),
          );
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
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}

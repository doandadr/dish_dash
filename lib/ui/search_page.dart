import 'package:dish_dash/common/style.dart';
import 'package:dish_dash/provider/restaurant_search_provider.dart';
import 'package:dish_dash/utils/result_state.dart';
import 'package:dish_dash/widget/card_restaurant.dart';
import 'package:dish_dash/widget/platform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const String searchTitle = "Search";

  const SearchPage({super.key});

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Restaurants',
          style: TextStyle(color: primaryColor, fontFamily: 'Hero'),
        ),
        leading: const Icon(
          Icons.manage_search_rounded,
          color: primaryColor,
        ),
      ),
      body: _buildSearchList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: Icon(CupertinoIcons.search_circle_fill),
        middle: Text("Search Restaurants"),
      ),
      child: _buildSearchList(context),
    );
  }

  Widget _buildSearchList(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SearchWidget(),
        Expanded(
          child: Consumer<RestaurantSearchProvider>(
              builder: (context, provider, _) {
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
                return const Center(
                  child: Material(
                    child: Text("Restaurant not found"),
                  ),
                );
              } else if (provider.state == ResultState.error) {
                return const Center(
                  child: Material(
                    child: Text("Error: Could not retrieve data from network"),
                  ),
                );
              } else {
                return const Material(
                  child: Text(''),
                );
              }
            }
          }),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final SearchController _searchController = SearchController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SearchBar(
        hintText: "Find by name or menus",
        elevation: const MaterialStatePropertyAll(6),
        surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.background),
        controller: _searchController,
        padding: const MaterialStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16)),
        onChanged: (_) {
          if (_searchController.text.isEmpty) return;
          Provider.of<RestaurantSearchProvider>(
            context,
            listen: false,
          ).searchRestaurants(_searchController.text);
        },
        trailing: <Widget>[
          Tooltip(
            message: 'Search for restaurants',
            child: IconButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(primaryColor),
                foregroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background),
              ),
              onPressed: () {
                if (_searchController.text.isEmpty) return;
                Provider.of<RestaurantSearchProvider>(
                  context,
                  listen: false,
                ).searchRestaurants(_searchController.text);
              },
              icon: const Icon(Icons.search),
            ),
          )
        ],
      ),
    );
  }
}

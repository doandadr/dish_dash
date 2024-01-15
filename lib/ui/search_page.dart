import 'package:dish_dash/common/style.dart';
import 'package:dish_dash/data/api/api_service.dart';
import 'package:dish_dash/provider/restaurant_search_provider.dart';
import 'package:dish_dash/provider/result_state.dart';
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
        elevation: 6,
        shadowColor: Colors.black,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
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
                return Expanded(
                  child: ListView.separated(
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
                  ),
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
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return RestaurantSearchProvider(apiService: ApiService());
      },
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
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
  List<String> searchHistory = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SearchAnchor(
        viewBackgroundColor: Colors.white,
        viewElevation: 0,
        viewHintText: 'Find restaurants',
        isFullScreen: false,
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            elevation: const MaterialStatePropertyAll(6),
            surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16)),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            trailing: <Widget>[
              Tooltip(
                message: 'Search for restaurants',
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      searchHistory.remove(controller.text);
                      searchHistory.insert(0, controller.text);
                    });
                    Provider.of<RestaurantSearchProvider>(
                      context,
                      listen: false,
                    ).searchRestaurants(controller.text);
                  },
                  icon: const Icon(Icons.search),
                ),
              )
            ],
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(searchHistory.length, (int index) {
            final String item = searchHistory[index];
            return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {

                  controller.closeView(item);

                });
                Provider.of<RestaurantSearchProvider>(
                  context,
                  listen: false,
                ).searchRestaurants(item);
              },
            );
          });
        },
      ),
    );
  }
}

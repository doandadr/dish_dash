import 'package:dish_dash/data/api/api_service.dart';
import 'package:dish_dash/data/model/restaurant_search_result.dart';
import 'package:flutter/cupertino.dart';

enum ResultState { loading, hasData, noData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late RestaurantSearchResult _searchResult;
  late ResultState _state;

  String _message = '';

  String get message => _message;

  RestaurantSearchResult get result => _searchResult;

  ResultState get state => _state;

  Future<dynamic> _searchRestaurants(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final searchResult = await apiService.searchRestaurants(query);
      if (searchResult.founded == 0 || searchResult.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = searchResult;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error --> $e";
    }
  }
}

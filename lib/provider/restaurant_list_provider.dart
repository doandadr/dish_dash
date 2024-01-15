import 'package:dish_dash/data/api/api_service.dart';
import 'package:dish_dash/data/model/restaurant_list_result.dart';
import 'package:dish_dash/provider/result_state.dart';
import 'package:flutter/cupertino.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({
    required this.apiService,
  }) {
    _getRestaurantList();
  }

  late RestaurantListResult _listResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantListResult get result => _listResult;

  ResultState get state => _state;

  Future<dynamic> _getRestaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await apiService.getRestaurantList();
      if (restaurantList.count == 0 || restaurantList.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();

        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listResult = restaurantList;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();

      return _message = 'Error --> $e';
    }
  }
}

import 'package:dish_dash/data/api/api_service.dart';
import 'package:dish_dash/data/model/restaurant_detail_result.dart';
import 'package:dish_dash/provider/result_state.dart';
import 'package:flutter/cupertino.dart';

class RestaurantDetailsProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailsProvider(
      {required this.apiService, required this.restaurantId}) {
    _fetchDetailRestaurant(restaurantId);
  }

  late RestaurantDetailResult _detailsResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetailResult get result => _detailsResult;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(String restaurantId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetails =
          await apiService.getRestaurantDetails(restaurantId);
      if (restaurantDetails.error == true) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Not Found";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailsResult = restaurantDetails;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

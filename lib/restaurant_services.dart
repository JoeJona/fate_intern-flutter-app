import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_list_app_fate_internship/restaurant_model.dart';

class RestaurantServices {
  Future<List<RestaurantModel>> getRestaurants() async {
    final loadJson = await rootBundle.loadString('assets/sample_data/restaurant.json');
    final List loadedList = jsonDecode(loadJson);
    return loadedList.map(((value) => RestaurantModel.fromJson(value))).toList();
  } 
}

final restaurantProvider = Provider<RestaurantServices>((ref) => RestaurantServices());
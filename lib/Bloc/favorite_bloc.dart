import 'dart:async';

import 'package:restaurant_finder/Bloc/bloc.dart';

import '../DataLayer/restaurant.dart';

class FavoriteBloc implements Bloc {
  var _restaurants = <Restaurant>[];
  List<Restaurant> get favorites => _restaurants;

  // Create a broadcast Stream 
  // meaning it can be listened to more than once
  // the app needs to listen to the stream in two places
  // if the app contains the restaurant and if not contains
  // hence use of broadcast;
  final _controller = StreamController<List<Restaurant>>.broadcast();
  Stream<List<Restaurant>> get favoritesStream => _controller.stream;

  void toggleRestaurant(Restaurant restaurant){
    if(_restaurants.contains(restaurant)){
      _restaurants.remove(restaurant);
    } else {
      _restaurants.add(restaurant);
    }

    _controller.sink.add(_restaurants);
  }


  @override
  void dispose() {
    _controller.close();
  }
  
}

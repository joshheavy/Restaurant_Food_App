import 'dart:async';

import 'package:restaurant_finder/Bloc/bloc.dart';

import 'package:restaurant_finder/DataLayer/location.dart';

class LocationBloc implements Bloc {
  Location _location;
  Location get selectedLocation => _location;

  // create a stream Controller of Location
  final _locationController = StreamController<Location>();

  // emits a Stream of location
  Stream<Location> get locationStream => _locationController.stream;

  // Select location
  void selectLocation(Location location) {
    _location = location;
    _locationController.sink.add(location);
  }

  @override
  void dispose() {
    _locationController.close();
  }
}

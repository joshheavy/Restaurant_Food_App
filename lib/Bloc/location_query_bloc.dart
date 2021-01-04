import 'dart:async';

import 'package:restaurant_finder/Bloc/bloc.dart';

import '../DataLayer/location.dart';
import '../DataLayer/zomato_client.dart';

class LocationQueryBloc implements Bloc {
  final _controller = StreamController<List<Location>>();
  final _client = ZomatoClient();

  // Create a Stream which is a list of Location
  Stream<List<Location>> get locationStream => _controller.stream;

  // Fetchs location from a api
  void submitQuery(String query) async {
    final results = await _client.fetchLocations(query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}

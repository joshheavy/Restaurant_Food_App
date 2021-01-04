import 'package:flutter/material.dart';
import 'package:restaurant_finder/Bloc/bloc_provider.dart';
import 'package:restaurant_finder/Bloc/restaurant_bloc.dart';

import '../DataLayer/location.dart';
import '../DataLayer/restaurant.dart';
import 'image_container.dart';

class RestaurantScreen extends StatelessWidget {
  final Location location;

  const RestaurantScreen({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.title),
      ),
      body: _buildSearch(context),
    );
  }

  Widget _buildSearch(BuildContext context) {
    final bloc = RestaurantBloc(location);
    return BlocProvider(
      bloc: bloc, 
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0), 
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(), 
                hintText: 'What do you want to eat?'
              ),
              onChanged: (query) => bloc.submitQuery(query),
            ),
          ), 
          Expanded(
            child: _buildStreamBuilder(bloc),
          ),
        ],
      ),
    );
  }

  Widget _buildStreamBuilder(RestaurantBloc bloc) {
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot){
        final results = snapshot.data;

        if (results == null){
          return Center(
            child: Text('Enter a restaurant name or a cuisine type'),
          );
        }

        if (results.isEmpty){
          return Center(
            child: Text('No Results'),
          );
        }

        return _buildSearchResults(results);
      }
    );
  }

  Widget _buildSearchResults(List<Restaurant> results) {
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index){
        final restaurant  = results[index];
        return RestaurantTile(restaurant: restaurant);
      },
    );
  }
}

class RestaurantTile extends StatelessWidget{
  final Restaurant restaurant; 
  const RestaurantTile({Key key, @required this.restaurant})
    : super(key: key);

  @override
  Widget build(BuildContext context){
    return ListTile(
      leading: ImageContainer(
        url: restaurant.thumbUrl, 
        width: 50,
        height: 50,
      ),
      title: Text(restaurant.name), 
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }
}

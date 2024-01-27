import 'package:favorite_places/places_list.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/place_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlaces extends ConsumerStatefulWidget {
  FavoritePlaces({super.key});

  @override
  ConsumerState<FavoritePlaces> createState() {
    return FavoritesPlacesState();
  }
}

class FavoritesPlacesState extends ConsumerState<FavoritePlaces> {
  late Future<void> placesfuture;

  void initState() {
    // TODO: implement initState
    super.initState();
    placesfuture = ref.read(UserPlacesProvider.notifier).loadplaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(UserPlacesProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text("Your Places",
              style: Theme.of(context).textTheme.titleLarge),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddPlaces(),
                ),
              ),
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: placesfuture,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : PlacesList(places: userPlaces),
          ),
        ));
  }
}

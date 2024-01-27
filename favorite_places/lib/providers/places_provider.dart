import 'package:riverpod/riverpod.dart';
import 'package:favorite_places/models/place.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> getdatabase() async {
  final dbpath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbpath, 'places.db'),
    onCreate: (db, version) {
      return
      db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL,lng REAL,address TEXT)');
    },
    version: 1
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super([]);

 Future <void> loadplaces() async {
    final db = await getdatabase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (row) => Place(
            id:row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
                address: row['address'] as String,
                langitude: row['lat'] as double,
                latitude: row['lng'] as double),
          ),
        )
        .toList();

        state=places;
  }

  void addPlace(String title, File? image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();

    final filename = path.basename(image!.path);
    final copiedimage = await image.copy('${appDir.path}/$filename');

    final newplace =
        Place(title: title, image: copiedimage, location: location);

    final db = await getdatabase();

    db.insert('user_places', {
      'id': newplace.id,
      'title': newplace.title,
      'image': newplace.image,
      'lat': newplace.location.latitude,
      'lng': newplace.location.langitude,
      'address':newplace.location.address
    });

    state = [ newplace,...state];
  }
}

final UserPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);

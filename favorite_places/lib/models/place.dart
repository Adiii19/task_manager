import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid=Uuid();

class PlaceLocation{

  const PlaceLocation({required this.address,required this.langitude,required this.latitude});

 final double latitude;
 final double langitude;
 final String address;

}

class Place{
  Place({required this.title,
  required this.image,
  required this.location,
  String ? id
  })
  :id=id??Uuid().v4();

 final String title;
 final String id;
 final File? image;
final PlaceLocation location;

}
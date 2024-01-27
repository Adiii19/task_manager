import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/maps_screen.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget{

 PlaceDetailsScreen({super.key,required this.place});

 final Place place;

String get locationimage{

    if (place.location == null) {
      return '';
    }

    final lat=place.location.latitude;
    final lng=place.location.langitude;
    return
            'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%$lat,$lng&key=AIzaSyAelfiMUF41wf194bu4qAHhDsLkxtKiltE';
           

  }

 @override
  Widget build(BuildContext context) {

    
    
    return

            Scaffold(
              appBar: AppBar(
                title: Text(place.title,style: Theme.of(context).textTheme.titleLarge!,),
              ),

              body: Stack(
                children: [
                  Image.file(place.image!,
                  fit: BoxFit.fill
                  ,
                  width: double.infinity,
                  height: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    
                    
                    child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx)=>
                            MapScreen(
                              location: place.location,
                              isSelecting: false,
                            ))
                          );
                        },
                        child: CircleAvatar(
                          radius:70 ,
                          backgroundImage: NetworkImage(locationimage),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16
                        ),
                        child: Text(
                          place.location.address,style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.transparent,
                            Colors.black54
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                          ),
                          
                        ),
                      )
                    ],
                  ))
                ],
              )
            );
    
  }


}
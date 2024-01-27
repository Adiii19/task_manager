import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget{
 const MapScreen({super.key,
  this.location=const PlaceLocation(
    address: '',
     langitude: -122.084,
      latitude:37.422),
      this.isSelecting=true});

  final PlaceLocation location;
  final bool isSelecting;


  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
    LatLng ?pickedlocation;
  @override
  Widget build(BuildContext context) {
    
      return
        Scaffold(
          appBar: AppBar(
            title: Text(widget.isSelecting?'Pick Your Location':'Your Location'),
           actions: [
               if(widget.isSelecting==true)
               IconButton(onPressed: (){
                 Navigator.of(context).pop(
                  pickedlocation
                 );
               }, icon: Icon(
                Icons.save
               ))
                
           ],
          ),
          body: GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(widget.location.latitude,widget.location.langitude)),
          markers:(pickedlocation==null && widget.isSelecting)?{}: {
            Marker(markerId: MarkerId('m1'),
            position: pickedlocation!=null?pickedlocation!:LatLng(widget.location.latitude, widget.location.langitude)),
            
          },
          onTap: !widget.isSelecting?null:(position) {
              setState(() {
           pickedlocation=position;
     });
          },
          ),
        );

  }
}
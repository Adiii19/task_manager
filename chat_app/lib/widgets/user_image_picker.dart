import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget{
  
  UserImagePicker({super.key,required this.onpickedimage});
  final void Function (File pickedimage) onpickedimage;
   
  @override
  State<UserImagePicker> createState() {
    // TODO: implement createState
    return 
              _UserImagePicker();
  }

}

class _UserImagePicker extends State<UserImagePicker>
{ 
    File ? pickedimagefile;

   void pickimage() async{

    final pickedimage=await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 50,maxWidth: 150);
     
    if(pickedimage==null)
    {
      return;
    }

     setState(() {
       pickedimagefile=File(pickedimage.path);
     });
  
     widget.onpickedimage(pickedimagefile!);

   }
  

    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return
           Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                foregroundImage: pickedimagefile != null?FileImage(pickedimagefile!):null,
              ),
              TextButton.icon(onPressed:(){
                pickimage();
              } , 
                 icon: Icon(Icons.image), label: Text('Add Image',style: TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),),
              ),

            ],
           );
  }

}
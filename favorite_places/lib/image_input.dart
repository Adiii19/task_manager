import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget{
  ImageInput({required this.onPickImage,super.key});

  final Function (File image)onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

 File? selectedimage; 
 
void takepicture () async
{
    final imagepicker=ImagePicker();
   final pickedimage=await imagepicker.pickImage(source: ImageSource.camera,
   maxWidth: 600);

   if(pickedimage==null)
   {
    return;
   }
  setState(() {
  selectedimage=File(pickedimage.path);
});

  widget.onPickImage(selectedimage!);

}

@override
  Widget build(BuildContext context) {
   
   
    Widget content=TextButton.icon(onPressed: 
              takepicture, 
              icon: Icon(Icons.camera_alt_outlined), 
              label: Text("Add picture")
              );

          
  if(selectedimage!=null)
  {
    content=GestureDetector(
      onTap:  takepicture,
      child: Image.file(selectedimage!,fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,),
    );
  }


        return
          Container(
              width: double.infinity,
              height: 250,
              alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.primary
                  )
                ),

              child: content

          );

  

}

}
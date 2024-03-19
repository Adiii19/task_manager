import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return
    _NewMessages();
  }


}

class _NewMessages extends State<NewMessages>{

   var messagecontroller=TextEditingController();

   @override
  void dispose() {
    // TODO: implement dispose
    messagecontroller.dispose();
    super.dispose();
    
  }

   void submitMessage()async{

   final enteredmessage=messagecontroller.text;

    if(enteredmessage.isEmpty)
    {
      return;
    }
      
      FocusScope.of(context).unfocus();
      messagecontroller.clear();


    final user=FirebaseAuth.instance.currentUser!;

     final userData=await FirebaseFirestore.instance.collection('users')
     .doc(user.uid)
     .get();

    FirebaseFirestore.instance.collection('chat').add({

        'text':enteredmessage,
        'createdAt':Timestamp.now(),
        'userId':user.uid,
        'username':userData.data()!['name'],
        'userImage':userData.data()!['imageURL'],

    });
 

   }


   @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 1,bottom: 10),
                child: TextField(
                    controller: messagecontroller,
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: true,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      labelText: 'Send a Message'
                    ),
                
                ),
              ),
            ),
            IconButton(onPressed: (){
              submitMessage();
              }
            , icon: Icon(Icons.send
            ,color: Theme.of(context).colorScheme.primary,))
          ],
        );
        

  }
    


}
import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

   final authenticateduser=FirebaseAuth.instance.currentUser;

   return // TODO: implement build
    StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',
      descending: true
      ).snapshots(),
      builder: (ctx,chatSnapshots){

     if(!chatSnapshots.hasData||chatSnapshots.data!.docs.isEmpty)
     {
       return 
              Center(
                child: Text('No messages found'),
              );

     }
     
       if(chatSnapshots.hasError){

        return
           Center(
            child: Text('Something went wrong...'),
           );
       }

        final loadedmessages=chatSnapshots.data!.docs;

      return
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40,
                    left: 13,
                    right: 13
                  ),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: loadedmessages.length,
                    itemBuilder: (ctx,index){
                      final ChatMessage=loadedmessages[index].data();
                      final nextChatMessage=index+1<loadedmessages.length?loadedmessages[index+1].data():null;
                      final currentMessageUserId=ChatMessage['userId'];
                      final nextMessageUserId = nextChatMessage !=null ?nextChatMessage['userId']:null;

                      final nextuserissame=nextMessageUserId==currentMessageUserId;

                      if(nextuserissame)
                      {
                        return
                                MessageBubble.next(message: ChatMessage['text'], isMe: authenticateduser!.uid==currentMessageUserId);

                      }
                      else{
                        return
                            MessageBubble.first(userImage: ChatMessage['userImage'], username: ChatMessage['username'], message: ChatMessage['text'], isMe:authenticateduser!.uid==currentMessageUserId );
                      }

                    }
                    ),
                );   

      });
  }


}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_manager2/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'widgets/taskItem.dart';

class Tasklist extends StatefulWidget {
  Tasklist(this.taskcurrent,{super.key});

    final  Task taskcurrent;

  @override
  State<Tasklist> createState() => _TasklistState();
}


class _TasklistState extends State<Tasklist> {
  final DatabaseReference databaseref = FirebaseDatabase.instance.ref().child('Tasklist');
  List<Task> loadedItems = [];
  
  late StreamSubscription _subscription;
  
   @override
  void initState(){
    super.initState();
    
     loadItems();
  }

  @override
  void dispose(){
    _subscription.cancel();
    super.dispose();
  }


  Future<void> loadItems() async { 


    _subscription = databaseref.onChildAdded.listen((event) {
  // Update the UI when a new child is added to the database
  final dynamic value = event.snapshot.value;
  if (value != null && value is Map<String, dynamic>) {
    final newTask = Task.fromJson(value);
    setState(() {
      loadedItems.add(newTask);
    });
  }
});

    final url = Uri.https('task-manager-app-67b0c-default-rtdb.firebaseio.com', '/Tasklist.json');
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      print('Failed to fetch data. Please try again.');
    }

    if (response.body == 'null') {
      print("BOdy null");
      setState(() {
        loadedItems = [];
      });
     
    }
 
    Map<String, dynamic>? data;
  try {
    data = json.decode(response.body) as Map<String, dynamic>?;
  } catch (e) {
    throw Exception('Failed to parse data. Please try again.');
  }

  if (data == null) {
    setState(() {
      loadedItems = [];
    });
    return;
  }

  final List<Task> tasks = data.values.map((value) => Task.fromJson(value)).toList();

  tasks.add(widget.taskcurrent);
    setState(() {
      
      loadedItems = tasks;
      
    });
  
    // Subscribe to changes in the database
    _subscription = databaseref.onChildRemoved.listen((event) {
      // Update the UI when a child is removed from the database
      setState(() {
        loadedItems.removeWhere((task) => task.id == event.snapshot.key);
      });
    });
   
  }
 
 Future<void> removeItem(Task task) async {
  var key = task.id;
  try {
    await databaseref.child(key).remove();
 
    setState(() {
      loadedItems.remove(task);
    });
  } catch (error) {
    // Handle error if needed
    print("Failed to remove task: $error");
  
}

 
 }
 

  @override
  Widget build(BuildContext context) {
    if (loadedItems.isEmpty) {
      return Center(child: Text("No tasks here. Kindly add your tasks",style: TextStyle(
        color: Colors.grey
      ),));
       // ignore: dead_code
       
    }
   

    return ListView.builder(
      itemCount: loadedItems.length,
      itemBuilder: (ctx, index) {
        
        final task = loadedItems[index];
        return Dismissible(
          key: ValueKey(task.id),
          direction: DismissDirection.horizontal,
          onDismissed: (direction) {
            removeItem(task);
          },
          child: Taskitem(task),
          background: Container(color: Colors.red),
        );
      },
    );
  }

 }


  


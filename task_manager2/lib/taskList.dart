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
  
  
  

  Future<void> loadItems() async {
    
    final url = Uri.https('task-manager-app-67b0c-default-rtdb.firebaseio.com', '/Tasklist.json');
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch data. Please try again.');
    }

    if (response.body == 'null') {
      setState(() {
        loadedItems = [];
      });
     return;
    }

    final Map<String, dynamic> listData = json.decode(response.body);
        final List<Task> tasks = listData.entries.map((entry) {
      final taskData = entry.value as Map<String, dynamic>;
      return Task.fromJson({...taskData,'id' : entry.key});
    }).toList();


    setState(()  {
      loadedItems = tasks;
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
  void initState() {
    super.initState();
    loadItems();
  }

  @override
  Widget build(BuildContext context) {
    if (loadedItems.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: loadedItems.length,
      itemBuilder: (ctx, index) {
        //loadedItems.add(widget.taskcurrent);
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


  


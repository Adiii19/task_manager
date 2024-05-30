import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager2/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:task_manager2/providers/task_provider.dart';
import 'widgets/taskItem.dart';
import 'package:riverpod/riverpod.dart';


class Tasklist extends ConsumerStatefulWidget{
  Tasklist({super.key});

  @override
 _TasklistState createState() => _TasklistState();
}

class _TasklistState extends ConsumerState<Tasklist> {
  final DatabaseReference databaseref = FirebaseDatabase.instance.ref().child('Tasklist');
  List<Task> loadedItems = [];
  
 
  
  @override
  void initState() {
    super.initState();
    loadItems();
  }


  Future<void> loadItems() async {
    final url = Uri.https('task-manager-app-67b0c-default-rtdb.firebaseio.com', '/Tasklist.json');
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      print('Failed to fetch data. Please try again.');
      return;
    }

    if (response.body == 'null') {
      print("Body null");
      setState(() {
        loadedItems = [];
      });
      return;
    }

     final jsondata=json.decode(response.body);

     List<Task> tasks=[];

     for(var item in jsondata){

        Task task= Task(taskname: item['taskname'], description: item['description'], hour: item['hour'], min: item['min'], id: item['id'], hourcheck: item['hourcheck']);
        tasks.add(task);
     }  
    
    for(var task in tasks)
    {
      ref.read(taskprovider.notifier).addTask(task);
    }
    

   
  }

  Future<void> removeItem(Task task) async {
    var key = task.id;
    try {
      await databaseref.child(key).remove();
       
    }catch (error) {
      print("Failed to remove task: $error");
    }
    
      // setState(() {
      //   loadedItems.remove(task);
      // });
    }

     
  

  @override
  Widget build(BuildContext context,) {

    final taskState=ref.watch(taskprovider);
    final taskNotifier=ref.read(taskprovider.notifier);

    if (taskState.isEmpty) {
      return Center(child: Text("No tasks here. Kindly add your tasks", style: TextStyle(
        color: Colors.grey
      ),));
    }

    return ListView.builder(
      itemCount: taskState.length,
      itemBuilder: (ctx, index) {
        final task = taskState[index];
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

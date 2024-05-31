import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_manager2/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:task_manager2/providers/task_provider.dart';
import 'widgets/taskItem.dart';
import 'package:riverpod/riverpod.dart';

class Tasklist extends ConsumerStatefulWidget {
  Tasklist({super.key});

  @override
  _TasklistState createState() => _TasklistState();
}

class _TasklistState extends ConsumerState<Tasklist> {
 
  List<Task> loadedItems=[];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    final url = Uri.https(
        'task-manager-app-67b0c-default-rtdb.firebaseio.com', '/Tasklist.json');
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

    final Map<dynamic, dynamic> data =
        json.decode(response.body) as Map<dynamic, dynamic>;
    for (var entry in data.entries) {
    
      
      final Task task = Task(
          taskname: entry.value['taskname'],
          description: entry.value['description'],
          date:DateTime.parse(entry.value['date']),
          hour: entry.value['hour'] as int,
          min: entry.value['min']as int,
          id: entry.value['id'],
          hourcheck: entry.value['hourcheck']as int);

          setState(() {
                ref.read(taskprovider.notifier).addTask(task);
          });
          print(task);
    }
  }

  

  @override
  Widget build(
    BuildContext context,
  ) {
    final taskState = ref.watch(taskprovider);


    if (taskState.isEmpty) {
      return Center(
          child: Text(
        "No tasks here. Kindly add your tasks",
        style: TextStyle(color: Colors.grey),
      ));
    }

    return ListView.builder(
      itemCount: taskState.length,
      itemBuilder: (ctx, index) {
        final task = taskState[index];
        
           Taskitem(task);
          
      },
    );
  }
}

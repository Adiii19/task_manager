import 'package:flutter/material.dart';
import 'package:task_manager2/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'widgets/taskItem.dart';

class Tasklist extends StatefulWidget {
  Tasklist({super.key});

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
    final List<Task> tasks = listData.values.map((value) => Task.fromJson(value)).toList();

    setState(() {
      loadedItems = tasks;
    });
  }
 
 Future<void> removeItem(Task task) async {
  var key = task.taskname;
  try {
    await databaseref.child(key).remove();
    setState(() {
      loadedItems.remove(task);
    });
  } catch (error) {
    // Handle error if needed
    print("Failed to remove task: $error");
    // You can also show a snackbar or dialog to inform the user about the error
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text("Failed to remove task"),
    //   ),
    // );
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
        final task = loadedItems[index];
        return Dismissible(
          key: ValueKey(task.taskname),
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

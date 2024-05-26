import 'package:flutter/material.dart';
import 'package:task_manager2/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'widgets/taskItem.dart';

class Tasklist extends StatefulWidget {
  Tasklist({super.key});

  @override
  State<Tasklist> createState() => _TasklistState();
}

class _TasklistState extends State<Tasklist> {
  Future<List<Task>> loadItems() async {
    final url = Uri.https('task-manager-app-67b0c-default-rtdb.firebaseio.com', '/Tasklist.json');
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch data. Please try again.');
    }

    if (response.body == 'null') {
      return [];
    }

    final List<Task> loadedItems = [];
    final Map<String, dynamic> listData = json.decode(response.body);
    listData.forEach((key, value) {
      loadedItems.add(Task.fromJson(value));
    });

    return loadedItems;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: loadItems(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No tasks found.'));
        }

        final tasks = snapshot.data!;

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(tasks[index]),
            child: Taskitem(tasks[index]),
          ),
        );
      },
    );
  }
}

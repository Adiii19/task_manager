import 'dart:convert';
import 'dart:ffi';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:task_manager2/newEntry.dart';
import 'package:task_manager2/widgets/taskItem.dart';
import 'package:task_manager2/models/model.dart';
import 'package:task_manager2/tasksScreen.dart';
import 'package:http/http.dart'as http;

class Tasklist extends StatefulWidget {

  Tasklist(this.tasks,{super.key});
  
    
    final List<Task> tasks ;
  @override
  State<Tasklist> createState() => _TasklistState();
}

class _TasklistState extends State<Tasklist> {
  
      List<Task>onregisteredtasks=[];
      
  var isloading=true;
  String? error;

   @override
  void initState() {
    super.initState();
   onregisteredtasks = widget.tasks;
    loaditem();
  }


  Future<void>  loaditem () async {

    final url=Uri.https('task-manager-app-67b0c-default-rtdb.firebaseio.com',
        '/Tasklist.json');
    final response=await http.get(url);
    if(response.statusCode>400)
    {
      setState(() {
        error='Failed to fetch data. Please try again.';
      });
    }

   if(response.body=='null')
   {
      setState(() {
        isloading=false;

      });
      return;
   }
     final List<Task> loadeditems=[];
     final Map<dynamic,dynamic> listdata=json.decode(response.body);
      for (final item in listdata.entries)
      {
        loadeditems.add(Task(taskname: item.value['taskname'], description: item.value['description'], date:  DateTime.parse(item.value['date']), hour: item.value['hour'], min: item.value['min'], rang: item.value['rang'], hourcheck: item.value['hourcheck']));
      }
      
      setState(() {
       
        onregisteredtasks=loadeditems;
         isloading=false;
      });
  }

  @override
  Widget build(BuildContext context) {
   
    return ListView.builder(
        itemCount: onregisteredtasks.length,
        itemBuilder: (ctx, index)=>Dismissible(key: ValueKey(onregisteredtasks[index].taskname),
              
              child: Taskitem(onregisteredtasks[index]),
             // onDismissed: (direction) => widget.onremovetask(onregisteredtasks[index]),
            ));
  }
}

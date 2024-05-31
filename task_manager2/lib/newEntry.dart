import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager2/models/model.dart';
import 'package:task_manager2/providers/task_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager2/tasksScreen.dart';

class NewEntry extends ConsumerStatefulWidget {
  NewEntry({ this.initialtask,super.key});

 final Task ?initialtask;

  @override
  ConsumerState<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends ConsumerState<NewEntry> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.initialtask!=null)
    {
       _taskNameController.text = widget.initialtask!.taskname;
      _taskDescriptionController.text = widget.initialtask!.description;
      selectedDate = widget.initialtask!.date;
      selectedTime = TimeOfDay(
        hour: widget.initialtask!.hour!,
        minute: widget.initialtask!.min!,);
    }
  }

  void timePicker() async {
    final now = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: now,
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
 
 
 

  Future<void> onaddtask() async {
    final url = Uri.https(
        'task-manager-app-67b0c-default-rtdb.firebaseio.com', '/Tasklist.json');
  
      final initialTask=widget.initialtask;

    try {
      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode({
          'taskname':initialTask?.taskname ?? _taskNameController.text,
          'description': initialTask?.description ?? _taskDescriptionController.text ,
          'date': selectedDate ?? initialTask?.date,
          'hour': selectedTime?.hour ?? initialTask!.hour,
          'min': selectedTime?.minute ?? initialTask!.min,
          'hourcheck': selectedTime?.hour ?? initialTask?.hour,
          
           // Firebase will generate the ID
        }),
      );

      if (response.statusCode >= 400) {
        print('Failed to add task. Please try again.');
        return;
      }

      final Map<dynamic, dynamic> data =
          json.decode(response.body) as Map<dynamic, dynamic>;

      Task task = Task(
          taskname: initialTask?.taskname ?? _taskNameController.text,
          description: initialTask?.description ?? _taskDescriptionController.text ,
          date: selectedDate ?? initialTask!.date,
          hour: selectedTime?.hour ?? initialTask!.hour,
          min: selectedTime?.minute ?? initialTask!.min,
          id: data['name'],
          hourcheck: selectedTime?.hour ?? initialTask?.hour,);

      // Extract the generated ID from the response
      final String id = data[
          'name']; // Assuming Firebase returns the ID in a field named 'name'

      task.id = id; // Update the task object with the generated ID

      // Add the task to the provider state
      if(initialTask!=null)
      {
        setState(() {
  ref.read(taskprovider.notifier).edittask(initialTask);
});
      }
      setState(() {
        ref.read(taskprovider.notifier).addTask(task);
      });
      print('Task added successfully!');
    } catch (error) {
      print('Error adding task: $error');
    }

    setState(() {
      _taskNameController.clear();
      _taskDescriptionController.clear();
      Tasksscreen();
    });

    Navigator.of(context).pop(Tasksscreen());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 224, 113, 105),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: TextField(
                  controller: _taskNameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "Task Name",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Color.fromARGB(255, 193, 128, 124),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: TextField(
                  controller: _taskDescriptionController,
                  maxLines: 6,
                  minLines: 1,
                  focusNode: FocusNode(),
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "Task Description",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.pink.shade200,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.50),
                  child: Column(
                    children: [
                      Text(
                        "Deadline:",
                        style:
                            GoogleFonts.lato(color: Colors.red, fontSize: 18),
                      ),
                      SizedBox(width: 5),
                      Row(
                        children: [
                          IconButton(
                            onPressed: presentDatePicker,
                            icon: Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            selectedDate == null
                                ? 'Select Date'
                                : formatter.format(selectedDate!),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: timePicker,
                            icon: Icon(
                              Icons.watch_later_outlined,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            selectedTime == null
                                ? 'Select Time'
                                : '${selectedTime!.hour}:${selectedTime!.minute}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       bottom: 15, top: 15, left: 100, right: 90),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         style: BorderStyle.solid,
            //         color: const Color.fromARGB(255, 224, 113, 105),
            //       ),
            //       borderRadius: BorderRadius.all(Radius.circular(8)),
            //     ),
            //     child: Center(
            //       child: Row(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(10.0),
            //             child: Text(
            //               "Pick a Color:",
            //               style: GoogleFonts.lato(
            //                 textStyle: TextStyle(color: Colors.white),
            //               ),
            //             ),
            //           ),
            //           const Spacer(),
            //           IconButton(
            //             onPressed: () {
            //               showDialog(
            //                 context: context,
            //                 builder: (context) {
            //                   return AlertDialog(
            //                     title: Text('Pick a color!'),
            //                     content: SingleChildScrollView(
            //                       child: ColorPicker(
            //                         pickerColor: pickerColor,
            //                         onColorChanged: changeColor,
            //                       ),
            //                     ),
            //                     actions: <Widget>[
            //                       ElevatedButton(
            //                         child: Text('Got it'),
            //                         onPressed: () {
            //                           setState(
            //                               () => currentColor = pickerColor);
            //                           Navigator.of(context).pop();
            //                         },
            //                       ),
            //                     ],
            //                   );
            //                 },
            //               );
            //             },
            //             icon: const Icon(Icons.color_lens_outlined),
            //             color: currentColor,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                onaddtask();
              },
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.pink.shade300,
                      const Color.fromARGB(255, 224, 113, 105),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                child: Text(
                  "Add Task",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

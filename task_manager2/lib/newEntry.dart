import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager2/models/model.dart';
import 'package:task_manager2/taskList.dart';
import 'package:task_manager2/widgets/taskItem.dart';

class NewEntry extends StatefulWidget {
  NewEntry( {super.key});

  @override
  State<NewEntry> createState() => _NewEntryState();
  
}

class _NewEntryState extends State<NewEntry> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Color currentColor = Colors.blue;
  Color pickerColor = Color(0xff443a49);

  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
   late Task task;

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

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  Future <void> onaddtask() async {
    if (_taskNameController.text.isEmpty ||
        _taskDescriptionController.text.isEmpty ||
        selectedDate == null ||
        selectedTime == null) {
      // Show an error message or a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    final task2 = Task(
        taskname: _taskNameController.text,
        description: _taskDescriptionController.text,
        date: selectedDate!,
        rang: currentColor,
        hour: selectedTime!.hour,
        min: selectedTime!.minute,
        hourcheck: selectedTime!.hour);
    final url = Uri.https(
        'task-manager-app-67b0c-default-rtdb.firebaseio.com',
        '/Tasklist.json');

    try {
  final response = await http.post(url,
      headers: {'Content-type': 'application/json'},
      body: json.encode({
        'taskname': task2.taskname,
        'description': task2.description,
        'date': task2.date?.toIso8601String(),
        'rang': task2.rang.toString(),
        'hour': task2.hour,
        'min': task2.min,
        'hourcheck': task2.hourcheck
      }));
      print(response.statusCode);
      print(response.body);
       
      final Map<dynamic,dynamic>resData=json.decode(response.body);
              task=Task(taskname:resData['taskname'], description: resData['description'], date:resData['date'], hour:resData['hour'] , min: resData['min'], rang: resData['rang'] ,hourcheck:resData['hourcheck']);
            List<Task> addedtask=[];
            addedtask.add(task);
      Navigator.of(context).pop(
        Tasklist(addedtask)
      );
    
  
    // if(response.statusCode==200)
    //  widget.onaddtask(task2);
} on Exception catch (e) {
  print(e);
}
        
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
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 15, top: 15, left: 100, right: 90),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: const Color.fromARGB(255, 224, 113, 105),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Pick a Color:",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Pick a color!'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: pickerColor,
                                    onColorChanged: changeColor,
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: Text('Got it'),
                                    onPressed: () {
                                      setState(
                                          () => currentColor = pickerColor);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.color_lens_outlined),
                        color: currentColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
               
                Navigator.of(context).pop(onaddtask());
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

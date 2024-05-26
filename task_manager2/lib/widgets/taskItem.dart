import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager2/authScreen.dart';
import 'package:task_manager2/models/model.dart';
import 'package:task_manager2/newEntry.dart';
import 'package:task_manager2/tasksScreen.dart';
import 'package:task_manager2/taskList.dart';
import 'package:http/http.dart'as http;

class Taskitem extends StatefulWidget {
  Taskitem(this.task,this.onregisteredtasks, {super.key});

  late final Task task;
  late final List<Task> onregisteredtasks;

  @override
  State<Taskitem> createState() => _TaskitemState();
}

class _TaskitemState extends State<Taskitem> {
  late AnimationController controller;

  late Animation<Offset> offsetAnimation;

  // void edittask(Task task, int index) {
  //   showModalBottomSheet(
  //     context: context,
  //     useSafeArea: true,
  //     isScrollControlled: true,
  //      sheetAnimationStyle: AnimationStyle(
  //           curve: Curves.bounceInOut, duration: Durations.long2),
       
  //     backgroundColor: const Color.fromARGB(255, 24, 24, 24),
  //     builder: (BuildContext context) => NewEntry(
  //       (updatedTask) {
  //         setState(() {
  //           // widget.edittask(updatedTask, index);
  //           widget.task.taskname = updatedTask.taskname;
  //           widget.task.description = updatedTask.description;
  //           widget.task.date = updatedTask.date;
  //           widget.task.hour = updatedTask.hour;
  //           widget.task.min = updatedTask.min;
  //           widget.task.rang = updatedTask.rang;
  //           widget.task.hourcheck = updatedTask.hourcheck;
  //         });
  //       },
  //     ),
  //   );
  // }

  removeitem(Task task,List<Task> loadedItems) async {
   

    final url = Uri.https('task-manager-app-67b0c-default-rtdb.firebaseio.com', '/Tasklist/${task.taskname}.json');
    final response = await http.delete(url);

    if (response.statusCode < 400) {
       final index = loadedItems.indexOf(task);
    setState(() {
      loadedItems.remove(task);
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onDoubleTap: () =>removeitem(widget.task,widget.onregisteredtasks) ,
        onTap: () {
          // edittask(
          //     Task(
          //         taskname: widget.task.taskname,
          //         description: widget.task.description,
          //         date: widget.task.date,
          //         hour: widget.task.hour,
          //         min: widget.task.min,
          //        rang: widget.task.rang,
          //         hourcheck: widget.task.hourcheck),
          //     0);
        },
        splashColor: Colors.pink.shade200,

        focusColor: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    widget.task.taskname,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                  Text(
                    widget.task.description,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 25),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Center(
                          child: Text('Deadline:',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25),
                              )),
                        ),
                        Text(
                          widget.task.Formatteddate.toString(),
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 25),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${widget.task.hour.toString()}:${widget.task.min.toString()}',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25),
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              widget.task.hourcheck < 12 ? 'AM' : 'PM',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.black87],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight))),
      ),
    );
  }
}

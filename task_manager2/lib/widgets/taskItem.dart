import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager2/authScreen.dart';
import 'package:task_manager2/models/model.dart';
import 'package:task_manager2/newEntry.dart';
import 'package:task_manager2/tasksScreen.dart';

class Taskitem extends StatefulWidget {
  Taskitem(this.task, {super.key});

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
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
                          color: Color.fromARGB(214, 255, 255, 255),
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
                        color: Color.fromARGB(72, 236, 232, 232)),
                    child: Column(
                      children: [
                        Center(
                          child: Text('Deadline:',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 231, 104, 95),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25),
                              )),
                        ),
                        Text(
                          widget.task.Formatteddate,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.white,
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
                              '${widget.task.hour}:${widget.task.min}',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Colors.white,
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
                                    color: Colors.white,
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
                    colors: [widget.task.rang, Colors.black87],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight))),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager2/authScreen.dart';
import 'package:task_manager2/models/model.dart';
import 'package:task_manager2/newEntry.dart';
import 'package:task_manager2/tasksScreen.dart';
import 'package:task_manager2/taskList.dart';
import 'package:http/http.dart'as http;

class Taskitem extends StatelessWidget {
  Taskitem(this.task,{super.key});

  late final Task task;
   //final Function(Task) onremove;

  late AnimationController controller;

  late Animation<Offset> offsetAnimation;

  // void edittask(Task task, int index) {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
       // onDoubleTap: () => onremove,
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
                    task.taskname,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                  Text(
                    task.description,
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
                        color: Colors.transparent),
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
                          task.Formatteddate.toString(),
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
                              '${task.hour.toString()}:${task.min.toString()}',
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

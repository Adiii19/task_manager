import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager2/models/model.dart';
import 'package:task_manager2/providers/task_provider.dart';
import 'package:firebase_database/firebase_database.dart';

class Taskitem extends ConsumerStatefulWidget {
  Taskitem(this.task, {super.key});

  late final Task task;

  @override
  ConsumerState<Taskitem> createState() => _TaskitemState();
}

class _TaskitemState extends ConsumerState<Taskitem> {
  
  late AnimationController controller;

  late Animation<Offset> offsetAnimation;

  final DatabaseReference databaseref =
      FirebaseDatabase.instance.ref().child('Tasklist');

  Future<void> removeItem(Task task) async {
    var key = task.id;
    try {
      await databaseref.child(key).remove();
    } catch (error) {
      print("Failed to remove task: $error");
    }

    setState(() {
      ref.read(taskprovider.notifier).delete(key);
    });

    
  }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                        Padding(
                          padding: const EdgeInsets.only(left: 130),
                          child: Center(
                            child: Text(
                              widget.task.taskname,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      
                      SizedBox(
                        width: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 75),
                        child: IconButton(
                            onPressed: () {
                             removeItem(widget.task);
                            },
                            icon: Container(
                              
                              decoration: BoxDecoration(
                                
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.red,
                                  
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(15))
                  
                              ),
                              child: Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.white,
                                size: 30,
                                
                              ),
                            )),
                      )
                    ],
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

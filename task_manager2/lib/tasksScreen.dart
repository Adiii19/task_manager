import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager2/taskList.dart';
import 'package:task_manager2/newEntry.dart';
import 'package:task_manager2/widgets/maindrawer.dart';

import 'models/model.dart';

class Tasksscreen extends StatefulWidget {
  @override
  State<Tasksscreen> createState() => _TasksscreenState();
}

class _TasksscreenState extends State<Tasksscreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2 =
      AnimationController(vsync: this, duration: Duration(seconds: 2));

  late Animation<Offset> offsetAnimation2;
  late Animation<double> _animation =
      CurvedAnimation(parent: controller2, curve: Curves.easeIn);


   Task Temp= Task(
        taskname: 'Task 1',
        description: 'descr',
        date: DateTime.now(),
        hour: 11,
        min: 11,
        id: '09',
        hourcheck: 11);
  

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    offsetAnimation2 = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    animationdelayer();
  }

  Future<void> animationdelayer() async {
    controller2.forward();
    await Future.delayed(Duration(seconds: 1));

    controller.forward();
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    controller.dispose();
  }

  void showmodealsheet() {
    showModalBottomSheet(
        sheetAnimationStyle: AnimationStyle(
            curve: Curves.bounceInOut, duration: Durations.long4),
        context: context,
        useSafeArea: true,
        constraints: BoxConstraints.expand(),
         isScrollControlled: true,
        elevation: 10,
        backgroundColor: Color.fromARGB(240, 15, 14, 14),
        builder: (BuildContext context) => NewEntry(
        ));
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      Tasklist;
    });

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: 220,
            width: 375,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(11, 204, 200, 200)
              ),
              borderRadius: BorderRadius.circular(30),
              color: Color.fromARGB(224, 15, 14, 14),

              boxShadow: [
                      BoxShadow(blurRadius: 7,
                      color: Color.fromARGB(32, 85, 83, 83).withOpacity(0.5),
                      blurStyle: BlurStyle.inner,
                      spreadRadius: 1
                      )]

                      
                      
                      
                      
                      
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "Task Manager",
                      style: GoogleFonts.lato(
                          fontSize: 30,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 20,
                      color: Colors.white,
                      onPressed: () {
                        showmodealsheet(
                          
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 350,
                  height: 120,
                  
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color.fromARGB(255, 4, 4, 80),Color.fromARGB(255, 124, 10, 145)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 7,
                      color: const Color.fromARGB(33, 0, 0, 0).withOpacity(0.5),
                      
                      spreadRadius: 1
                      
                      )
                
                    ],
                    borderRadius: BorderRadius.circular(15),
                              ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: FadeTransition(
                          opacity: _animation,
                          child: Text(
                            "Hi Aditya!",
                            style: GoogleFonts.lato(
                                fontSize: 50,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 150),
                        child: Text(
                          "Here's your task list:",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(color: Colors.white70, fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SlideTransition(
              position: offsetAnimation2,
              child: Tasklist(
                 
              ),
            ),
          ),
        ],
      ),
    );
  }
}

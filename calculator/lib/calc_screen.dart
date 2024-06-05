import 'package:calculator/solve_provider.dart';
import 'package:calculator/widgets/num_button.dart';
import 'package:calculator/widgets/num_button_3.dart';
import 'package:calculator/widgets/num_button_4.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calculator/calc_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator/widgets/num_button_2.dart';

class CalcScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends ConsumerState<CalcScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final result = ref.watch(solveprovider);
    final calcval = ref.watch(calcprovider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Calculator",
          style: GoogleFonts.lato(
            color: Colors.white
          )
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 25,top: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(77, 228, 225, 225),
                  border: Border.all(color: const Color.fromARGB(255, 122, 124, 126)),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      calcval,
                      style: GoogleFonts.lato(color: Colors.black, fontSize: 40,fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '= ${result}',
                      style: GoogleFonts.lato(color: Color.fromARGB(255, 166, 159, 159), fontSize: 25,fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              width: 500,
              height: 340,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right:27),
            child: Container(

              width: 450,
              height: 410,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 226, 221, 221),
                 border: Border.all(color: const Color.fromARGB(255, 122, 124, 126)),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Column(
                    
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 19, top: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              
                                 Container(
                                 height: 60,
                                 width: 60,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(1, 3),
                                      blurRadius: 2,
                                      color: Colors.black,
                                      spreadRadius: 1
                                    )
                                  ],
                                    gradient: LinearGradient(colors: [
                                      
                                      Color.fromARGB(255, 10, 65, 111),
                                      Color.fromARGB(255, 71, 146, 207),
                                    ],
                                    begin:AlignmentDirectional.topCenter,
                                    end: FractionalOffset.bottomCenter),
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.blue),
                        child: TextButton(
                            onPressed: () {
                             
                           ref.read(calcprovider.notifier).clear();
                            ref.read(solveprovider.notifier).clear();
                            },
                           child: Text("C", style:GoogleFonts.poppins(
              color: Colors.white,fontSize: 30
            ),),)),
                              SizedBox(
                                width: 13,
                              ),
                             
                                 NumButton('%'),
                              
                              SizedBox(
                                width: 13,
                              ),
                              
                                Container(
                                 height: 60,
                                 width: 60,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(1, 3),
                                      blurRadius: 2,
                                      color: Colors.black,
                                      spreadRadius: 1
                                    )
                                  ],
                                    gradient: LinearGradient(colors: [
                                      
                                      Color.fromARGB(255, 10, 65, 111),
                                      Color.fromARGB(255, 71, 146, 207),
                                    ],
                                    begin:AlignmentDirectional.topCenter,
                                    end: FractionalOffset.bottomCenter),
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.blue),
                        child: IconButton(
                            onPressed: () {
                              ref.read(calcprovider.notifier).backspace();
                            },
                            icon: Icon(Icons.backspace_outlined,color: Colors.white,))) ,
                              
                              SizedBox(
                                width: 13,
                              ),
                               
                                 Container(
                                  
                                 height: 60,
                                 width: 70,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(1, 3),
                                      blurRadius: 2,
                                      color: Colors.black,
                                      spreadRadius: 1
                                    )
                                  ],
                                    gradient: LinearGradient(colors: [
                                      
                                      Color.fromARGB(255, 10, 65, 111),
                                      Color.fromARGB(255, 71, 146, 207),
                                    ],
                                    begin:AlignmentDirectional.topCenter,
                                    end: FractionalOffset.bottomCenter),
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.blue),
                        child: TextButton(
                            onPressed: () {
                              ref.read(solveprovider.notifier).solve();
                              ref.read(calcprovider.notifier).display_num('/');
                            },
                             child: Text('/',style: TextStyle(
                              color: Colors.white,
                              fontSize: 30
                             ),),
                        )
                                 )
                             
                            ],
                          ),
                        ],
                      ),
                    ),
                             
                             Padding(
                      padding: const EdgeInsets.only(left: 19, top: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              
                                NumButton2('7'),
                              SizedBox(
                                width: 13,
                              ),
                             
                                 NumButton2('8'),
                              
                              SizedBox(
                                width: 13,
                              ),
                    
                              NumButton2('9'),
                               SizedBox(
                                width: 13,
                              ),
                              
                                NumButton("X") ,
                              
                           
                                
                               
                                 
                             
                            ],
                          ),
                        
                        
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 19, top: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              
                                NumButton2('4'),
                              SizedBox(
                                width: 13,
                              ),
                             
                                 NumButton2('5'),
                              
                              SizedBox(
                                width: 13,
                              ),
                    
                              NumButton2('6'),
                               SizedBox(
                                width: 13,
                              ),
                              
                                NumButton("-") ,
                              
                           
                                
                               
                                 
                             
                            ],
                          ),
                        
                        
                        ],
                      ),
                    ),
                            Padding(
                      padding: const EdgeInsets.only(left: 19, top: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              
                                NumButton2('1'),
                              SizedBox(
                                width: 13,
                              ),
                             
                                 NumButton2('2'),
                              
                              SizedBox(
                                width: 13,
                              ),
                    
                              NumButton2('3'),
                               SizedBox(
                                width: 13,
                              ),
                              
                                NumButton("+") ,
                              
                           
                                
                               
                                 
                             
                            ],
                          ),
                        
                        
                    
                        
                        
                        ],
                      ),
                    ), 
                    
                     Padding(
                      padding: const EdgeInsets.only(left: 19, top: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              
                                NumButton4('0'),
                              SizedBox(
                                width: 13,
                              ),
                             
                                 NumButton2('.'),
                              
                              SizedBox(
                                width: 13,
                              ),
                    
                              NumButton3('='),
                               SizedBox(
                                width: 13,
                              ),
                           
                                
                               
                                 
                             
                            ],
                          ),
                        
                        
                    
                        
                        
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ), 

          
           
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:calculator/calc_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class NumButton2 extends ConsumerWidget {
  NumButton2(this.number, );
  final String number;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // TODO: implement build
    return Container(height: 60,
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
                            
                            Color.fromARGB(255, 17, 42, 63),
                            Color.fromARGB(255, 2, 17, 30),
                          ],
                          begin:AlignmentDirectional.topCenter,
                          end: FractionalOffset.bottomCenter),
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.blue),
                     
      child: TextButton(
          onPressed: () {
            ref.read(calcprovider.notifier).display_num(number);
          },
          child: Text(
            number,
            style:GoogleFonts.poppins(
              color: Colors.white,fontSize: 30
            ),
          )),
    );
  }
}

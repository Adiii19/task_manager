import 'dart:ffi';
import 'dart:ui';

import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Calcnotifier extends StateNotifier<String>{

Calcnotifier():super("");

void display_num(String elem){

if(RegExp(r'^[0-9]$').hasMatch(elem)){

   state=state+elem;
}

else{
   
  state=state+''+elem+'';
  
}




}

 backspace(){
  if(state.isNotEmpty)
  {
    state=state.substring(0,state.length-1);
  }
}

void clear(){

state='';

}


}




final calcprovider=StateNotifierProvider<Calcnotifier,String>((ref){
  return Calcnotifier();
});
import 'package:riverpod/riverpod.dart';
import 'package:task_manager2/models/model.dart';

class Tasknotifier extends StateNotifier<List<Task>>{

Tasknotifier():super([]);

 addTask(Task task)
{
  state=[...state,task];

}

void delete(String id)
{
  state=state.where((task)=>task.id!=id).toList();
}

void loadtasks(List<Task> tasks)
{
  state=tasks;
}

void edittask(Task task){

final index=state.indexWhere((existingtask)=>existingtask.id==task.id);
if(index!=-1)
{
  state[index]=task;
}
else{
  print('Error:Task with ID ${task.id} not found for editing');
}

}

}



final taskprovider= StateNotifierProvider<Tasknotifier,List<Task>>((ref){
  return Tasknotifier();
});
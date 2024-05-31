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

void edittask(Task task) {
  state = state.map((existingTask) {
    return existingTask.id == task.id ? task : existingTask;
  }).toList();
}


}



final taskprovider= StateNotifierProvider<Tasknotifier,List<Task>>((ref){
  return Tasknotifier();
});
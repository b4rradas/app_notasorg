import 'package:app_notasorg/model/notas_model.dart';


class NotasController {
  final List<Nota> _tasks = [];

  List<Nota> get tasks => _tasks;
  
  Nota read(int index) {
  return _tasks[index];
}

  void addTask(Nota task) {
    _tasks.add(task);
  }

  void removeTask(Nota task) {
    _tasks.remove(task);
  }

  void editTask(int index, Nota updatedTask) {
    _tasks[index] = updatedTask;
  }

  List<Nota> filterByGroup(String group) {
    return _tasks.where((task) => task.group == group).toList();
  }
}

import 'package:app_notasorg/model/notas_model.dart';


class NotasController {
  final List<Nota> _tasks = [];
  final List<Nota> _concludedtask = [];
  final List<Nota> _archivedtask = [];
  final List<Nota> _deletedtask = [];
  

  List<Nota> get tasks => _tasks;
  List<Nota> get concludedtask => _concludedtask;
  List<Nota> get archivedtask => _archivedtask;
  List<Nota> get deletedtask => _deletedtask;
  
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

  void concludeTask(Nota task) {
    _tasks.remove(task);
    _concludedtask.add(task);
  }

  void archiveTask(Nota task) {
    _tasks.remove(task);
    _archivedtask.add(task);
  }

  void deleteTask(Nota task) {
    _tasks.remove(task);
    _deletedtask.add(task);
  }

  List<Nota> filterByGroup(String group) {
    return _tasks.where((task) => task.group == group).toList();
  }
}

import 'package:app_notasorg/model/notas_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotasController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  /// adiciona uma nota no Firestore e local
  Future<void> addTask(Nota task) async {
    final uid = _auth.currentUser!.uid;

    final docRef = await _firestore
        .collection('usuarios')
        .doc(uid)
        .collection('notas')
        .add({
      'name': task.name,
      'description': task.description,
      'priorityTag': task.priorityTag,
      'group': task.group,
      'status': task.status,
      'createdAt': Timestamp.now(),
    });

    task.id = docRef.id;
    _tasks.add(task);
  }

  /// editar nota no Firestore e local
  Future<void> editTask(Nota updatedTask) async {
  final uid = _auth.currentUser!.uid;
  final docId = updatedTask.id;

  await _firestore
      .collection('usuarios')
      .doc(uid)
      .collection('notas')
      .doc(docId)
      .update({
    'name': updatedTask.name,
    'description': updatedTask.description,
    'priorityTag': updatedTask.priorityTag,
    'group': updatedTask.group,
    'status': updatedTask.status, // 🔥 Garante que o status não muda
  });
}


  /// stream de notas do usuário (todas as notas, independente do status)
Stream<List<Nota>> getNotasDoUsuario() {
  final uid = _auth.currentUser!.uid;

  return _firestore
      .collection('usuarios')
      .doc(uid)
      .collection('notas')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return Nota(
            id: doc.id,
            name: data['name'] ?? '',
            description: data['description'] ?? '',
            priorityTag: data['priorityTag'] ?? '',
            group: data['group'] ?? '',
            status: data['status'] ?? 'active', // 🔥 Pega o status do Firestore
          );
        }).toList();
      });
}



  Future<void> archiveTask(Nota task) async {
    await _updateStatus(task, 'archived');
    _tasks.remove(task);
    _archivedtask.add(task);
  }

  Future<void> concludeTask(Nota task) async {
    await _updateStatus(task, 'concluded');
    _tasks.remove(task);
    _concludedtask.add(task);
  }

  Future<void> restoreTask(Nota task) async {
    await _updateStatus(task, 'active');
    _archivedtask.remove(task);
    _concludedtask.remove(task);
    _deletedtask.remove(task);
    _tasks.add(task);
  }

  Future<void> deleteTask(Nota task) async {
    await _updateStatus(task, 'deleted');
    _tasks.remove(task);
    _deletedtask.add(task);
  }

  /// atualiza status da nota
  Future<void> _updateStatus(Nota task, String status) async {
    final uid = _auth.currentUser!.uid;
    final docId = task.id;

    await _firestore
        .collection('usuarios')
        .doc(uid)
        .collection('notas')
        .doc(docId)
        .update({'status': status});
  }

  /// carregar as notas do Firestore
  Future<void> loadTasks() async {
    final uid = _auth.currentUser!.uid;

    final snapshot = await _firestore
        .collection('usuarios')
        .doc(uid)
        .collection('notas')
        .orderBy('createdAt', descending: true)
        .get();

    _tasks.clear();
    _archivedtask.clear();
    _concludedtask.clear();
    _deletedtask.clear();

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final nota = Nota(
        id: doc.id,
        name: data['name'],
        description: data['description'],
        priorityTag: data['priorityTag'],
        group: data['group'],
      );

      switch (data['status']) {
        case 'active':
          _tasks.add(nota);
          break;
        case 'archived':
          _archivedtask.add(nota);
          break;
        case 'concluded':
          _concludedtask.add(nota);
          break;
        case 'deleted':
          _deletedtask.add(nota);
          break;
      }
    }
  }

  /// filtrar por grupo
  List<Nota> filterByGroup(String group) {
    return _tasks.where((task) => task.group == group).toList();
  }
}

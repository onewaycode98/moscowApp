import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/models/task_model.dart';
import 'package:todoapp/core/services/api.dart';
import 'package:todoapp/locator.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Task> tasks;

  Future<List<Task>> fetchTasks() async {
    var result = await _api.getDataCollection();
    tasks = result.docs.map((doc) => Task.fromMap(doc.data(), doc.id)).toList();
    return tasks;
  }

  Stream<QuerySnapshot> chooseStream(String category, String cat) {
    if (category == 'All') {
      return fetchStreamTasks();
    } else {
      return fetchStreamTaskByCategory(cat);
    }
  }

  Stream<QuerySnapshot> fetchStreamTasks() {
    return _api.streamDataCollection();
  }

  Stream<QuerySnapshot> fetchStreamTaskByCategory(String cat) {
    return FirebaseFirestore.instance
        .collection('tasks')
        .where('category', isEqualTo: cat)
        .snapshots();
  }

  Future<Task> getTaskById(String id) async {
    var doc = await _api.getDocumentById(id);
    print(id);
    return Task.fromMap(doc.data(), doc.id);
  }

  Future removeTask(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateTask(Task data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addTask(Task data) async {
    await _api.addDocument(data.toJson());
    return;
  }
}

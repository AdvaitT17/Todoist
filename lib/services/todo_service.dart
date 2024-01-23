 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoist/model/todo_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance.collection('todoApp');

  // CREATE

  void AddNewTask(TodoModel model){
    todoCollection.add(model.toMap());
  }
 }
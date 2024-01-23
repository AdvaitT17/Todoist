import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/services/todo_service.dart';

import '../model/todo_model.dart';

final serviceProvider = StateProvider<TodoService>((ref) {
  return TodoService();
});


final fetchStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
  .collection('todoApp')
  .snapshots()
  .map((event) => 
    event.docs.map((snapshot) => TodoModel.fromSnapshot(snapshot)).toList());
  yield* getData;
});
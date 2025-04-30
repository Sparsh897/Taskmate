import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task_mate/models/todo_modal.dart';

class TodoController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var todos = <TodoModel>[].obs;
  late String uid;

  void init(String userId) {
    uid = userId;
    fetchTodos();
  }

  void fetchTodos() {
    _firestore
        .collection('users')
        .doc(uid)
        .collection('todos')
        .snapshots()
        .listen((snapshot) {
      todos.value =
          snapshot.docs.map((doc) => TodoModel.fromFirestore(doc)).toList();
    });
  }

  Future<void> addTodo(String title) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('todos')
        .add({'title': title, 'isDone': false});
  }

  Future<void> updateTodoStatus(String id, bool isDone) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(id)
        .update({'isDone': isDone});
  }

  Future<void> deleteTodo(String id) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(id)
        .delete();
  }
}

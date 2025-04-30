import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String id;
  final String title;
  final bool isDone;

  TodoModel({required this.id, required this.title, required this.isDone});

  factory TodoModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodoModel(
      id: doc.id,
      title: data['title'],
      isDone: data['isDone'],
    );
  }
}

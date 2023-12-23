import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_fine_machine_test/Model/todo_model.dart';

class FirebaseServices {
  Future<void> addCategory(TodoCategory category) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference categories = FirebaseFirestore.instance.collection(
        'todo-categories',
      );

      DocumentReference docRef = categories.doc();

      // Add category id as collectinId
      category.uid = docRef.id;

      Map<String, dynamic> categoryData = category.toJson();

      await docRef.set(categoryData);
    } catch (e) {
      log('error adding category $e');
    }
  }

  Future<void> addTodo({required String uid, required Todo todo}) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference categories = FirebaseFirestore.instance.collection(
        'todo-categories',
      );

      DocumentReference docRef = categories.doc(uid);

      // Create Another collectin store todo data

      final todoDoc = docRef.collection('todo-list');

      Map<String, dynamic> todoData = todo.toJson();

      await todoDoc.add(todoData);
    } catch (e) {
      log('error adding category $e');
    }
  }
}

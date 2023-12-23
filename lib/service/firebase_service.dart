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

      final todoCollection = docRef.collection('todo-list');

      final todoDoc = todoCollection.doc();

      todo.uid = todoDoc.id;

      Map<String, dynamic> todoData = todo.toJson();

      await todoDoc.set(todoData);
    } catch (e) {
      log('error adding category $e');
    }
  }

  Future<void> updateTodo({required String uid, required Todo todo}) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference categories = FirebaseFirestore.instance.collection(
        'todo-categories',
      );

      DocumentReference docRef = categories.doc(uid);

      // Create Another collectin store todo data

      final todoCollection = docRef.collection('todo-list');

      final todoDoc = todoCollection.doc(todo.uid);

      Map<String, dynamic> todoData = todo.toJson();

      await todoDoc.update(todoData);
    } catch (e) {
      log('error adding category $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTodoList({required TodoCategory todoCategory}) {
    return FirebaseFirestore.instance
        .collection('todo-categories')
        .doc(todoCategory.uid)
        .collection(
          'todo-list',
        )
        .snapshots();
  }
}

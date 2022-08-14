import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Data_MOdel/Task_Model.dart';



CollectionReference<TaskModel> getTasksFromFireStore() {
  return FirebaseFirestore.instance
      .collection('tasks')
      .withConverter<TaskModel>(
          fromFirestore: (snapshot, op) {
            return TaskModel.fromJson(snapshot.data()!);
          },
          toFirestore: (task, option) {
            return task.toJson();
          });
}

Future<void> addTaskFromFireBase(TaskModel task) {
  var TypeCollection = getTasksFromFireStore();
  var doc = TypeCollection.doc();
  task.id = doc.id;
  return doc.set(task);
}
// Future<void> EditTaskFromFireBase(TaskModel task) {
//   var TypeCollection = getTasksFromFireStore();
//   var doc = TypeCollection.doc();
//   task.id = doc.id;
//   return doc.update(task.toJson());
// }

Future<void> deleteTaskFromFireStore(TaskModel task) {
  // var deletedTask =getTasksFromFireStore();
  // deletedTask.doc(task.id).delete();
  return getTasksFromFireStore().doc(task.id).delete();
}
Future<void> EditTaskFromFireStore(TaskModel task) {
  var TypeCollection = getTasksFromFireStore();
  //var doc = TypeCollection.doc();
 // task.id = doc.id;
  //TypeCollection.doc(task.id).update(task.toJson());
  return TypeCollection.doc(task.id).update(task.toJson());
}


 Future<QuerySnapshot<TaskModel>> getTasksFromFirebase(DateTime dateTime) {
  var tasks = getTasksFromFireStore();
  return tasks
      .where('date',
          isEqualTo: DateUtils.dateOnly(dateTime).microsecondsSinceEpoch)
      .get();
}


Stream<QuerySnapshot<TaskModel>> getTasksFromFirebaseUseingStream(
    DateTime dateTime) {
  var tasks = getTasksFromFireStore();
  return tasks
      .where('date',
          isEqualTo: DateUtils.dateOnly(dateTime).microsecondsSinceEpoch)
      .snapshots();
}

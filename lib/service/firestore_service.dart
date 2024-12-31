import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Delete a todo by its document ID and ensure it belongs to the current user.
  Future<void> deleteTodo(String transaksiDocId, String userUid) async {
    try {
      // Ensure the todo belongs to the current user
      final todoDoc = await _firestore.collection('Todos').doc(transaksiDocId).get();
      if (todoDoc.exists && todoDoc.data()?['uid'] == userUid) {
        await _firestore.collection('Todos').doc(transaksiDocId).delete();
      } else {
        throw Exception("Todo does not belong to the current user or does not exist.");
      }
    } catch (e) {
      print("Error deleting todo: $e");
      rethrow;
    }
  }

  // Update a todo by its document ID with new title, description, and an optional 'isComplete' state
  Future<void> updateTodo(
      String transaksiDocId, String title, String description, bool? isComplete) async {
    try {
      final updateData = {
        'title': title,
        'description': description,
      };
      if (isComplete != null) {
        updateData['isComplete'] = isComplete;  // Only update isComplete if passed
      }
      await _firestore.collection('Todos').doc(transaksiDocId).update(updateData);
    } catch (e) {
      print("Error updating todo: $e");
      rethrow;
    }
  }
}

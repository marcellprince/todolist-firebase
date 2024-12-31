class Todo {
  final String id; // Firestore document ID
  final String title;
  final String description;
  final bool isComplete;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isComplete,
  });

  // Factory method to create a Todo object from Firestore data
  factory Todo.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Todo(
      id: documentId,
      title: data['title'],
      description: data['description'],
      isComplete: data['isComplete'],
    );
  }

  // Convert a Todo object to a Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'isComplete': isComplete,
    };
  }
}

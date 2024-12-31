import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import '../model/todo.dart';
import '../model/item_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  bool isComplete = false;

  Future<QuerySnapshot<Map<String, dynamic>>>? searchResultsFuture;

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Future<void> searchResult(String textEntered) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection("Todos")
        .where("title", isGreaterThanOrEqualTo: textEntered)
        .where("title", isLessThan: textEntered + 'z')
        .get();

    setState(() {
      searchResultsFuture = Future.value(querySnapshot);
    });
  }

  void cleartext() {
    _titleController.clear();
    _descriptionController.clear();
  }

  Future<void> addTodo() {
    return _firestore.collection('Todos').add({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'isComplete': isComplete,
    }).catchError((error) => print('Failed to add todo: $error'));
  }

  Widget _buildTodoList(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, User? user) {
    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    List<Todo> listTodo = snapshot.data!.docs.map((document) {
      final data = document.data();
      final String documentId = document.id; // Firestore Document ID
      return Todo.fromFirestore(data, documentId); // Use the fromFirestore constructor
    }).toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: listTodo.length,
      itemBuilder: (context, index) {
        return ItemList(
          todo: listTodo[index],
          transaksiDocId: snapshot.data!.docs[index].id,
          todoCollection: _firestore.collection('Todos'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: searchResult,
            ),
          ),
          Expanded(
            child: _searchController.text.isEmpty
                ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _firestore
                  .collection('Todos')
                  .where('uid', isEqualTo: user!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                return _buildTodoList(snapshot, user);
              },
            )
                : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: searchResultsFuture,
              builder: (context, snapshot) {
                return _buildTodoList(snapshot, user);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Tambah Todo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Judul todo'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(hintText: 'Deskripsi todo'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Batalkan'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text('Tambah'),
                  onPressed: () {
                    addTodo();
                    cleartext();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post_app/models/post.dart';
import 'package:post_app/services/auth.dart';
import 'package:post_app/services/database.dart';
import 'package:post_app/view/create_post.dart';

class Home extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Home({Key? key, required this.auth, required this.firestore})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  CollectionReference post = FirebaseFirestore.instance.collection('posts');
  List<String> documentId=[];


  Future getDecId()async{
    await FirebaseFirestore.instance.collection("posts").get()
    .then((snapshot) => snapshot.docs.forEach((document) { 
      documentId.add(document.reference.id);

    }));

  }

  Future<void> updatePost(String docId) {
  return post
    .doc(docId)
    .update({'company': 'Stokes and Sons'})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}

Future<void> deletePost(String docId) {
  return post
    .doc(docId)
    .delete()
    .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content:  Text('Deleted Successfully'),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    margin: const EdgeInsets.only(
        top: 5,
        right: 20,
        left: 20),
  )))
    .catchError((error) => print("Failed to delete user: $error"));
}


  @override
  void initState() {
    getDecId();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(""),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Authenticate(auth: widget.auth).signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body:FutureBuilder(
        future: getDecId(),
        builder:(context, snapshot) => 
        ListView.builder(
          itemCount: documentId.length,
          itemBuilder: ((context, index) => 
          GetPosts(documentId: documentId[index],)
          ),
        )
         ) ,
           );
      // ignore: dead_code
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePost()),
          );
        },
        child: const Center(child: Icon(Icons.add)),
        backgroundColor:  Colors.black,
      );
    
  }
}

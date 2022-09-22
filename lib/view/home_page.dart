// ignore_for_file: unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post_app/services/auth.dart';
import 'package:post_app/view/create_post.dart';

class Home extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Home({Key? key, required this.auth, required this.firestore})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference post = FirebaseFirestore.instance.collection('posts');
  List<String> documentId = [];
  final TextEditingController title = TextEditingController();

  final TextEditingController content = TextEditingController();

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection("posts")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              documentId.add(document.reference.id);
            }));
  }

  Future<void> _update(DocumentSnapshot? documentSnapshot) async {
    if (documentSnapshot != null) {
      title.text = documentSnapshot["title"];
      content.text = documentSnapshot["content"];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: title,
                  decoration: const InputDecoration(
                    labelText: "Title",
                  ),
                ),
                TextField(
                  controller: content,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: "Update Post",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String myTitle = title.text;
                      final String task = content.text;

                      await post
                          .doc(documentSnapshot!.id)
                          .update({"title": myTitle, "content": task});
                      title.clear();
                      content.clear();
                    },
                    child: const Text("Update"))
              ],
            ),
          );
        });
  }

  Future<void> _deletePost(DocumentSnapshot? documentSnapshot) {
    return post
        .doc(documentSnapshot!.id)
        .delete()
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Deleted Successfully'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: const EdgeInsets.only(top: 5, right: 20, left: 20),
            )))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  void _showcontent(DocumentSnapshot? documentSnapshot) {
    showDialog(
      context: context,
       barrierDismissible: false,

      builder: (BuildContext context) {
        return new AlertDialog(
          title: const Text("Confirm and Delete?",style: TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(documentSnapshot!['content']),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             TextButton(
              child: const Text('Delete'),
              onPressed: () async{
                _deletePost(documentSnapshot);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _readDialog(DocumentSnapshot? documentSnapshot) {
    showDialog(
      context: context,
       barrierDismissible: false,

      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text(documentSnapshot!['title'],style: const TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(documentSnapshot['content'],style: const TextStyle(color: Colors.grey),),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getDocId();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Home Page"),
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
          body: StreamBuilder(
              stream: post.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                if (streamsnapshot.hasData) {
                  return ListView.builder(
                      itemCount: streamsnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamsnapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 32,
                                    ),
                                   const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'By ${documentSnapshot["name"]}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          documentSnapshot["title"],
                                          style: const TextStyle(
                                              fontSize: 32,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                               const SizedBox(height: 10,),
                                Text(
                                  documentSnapshot["content"],
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        _readDialog(documentSnapshot);
                                      },
                                      child: const Text("Read"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        _update(documentSnapshot);
                                      },
                                      
                                      
                                      child: const Icon(Icons.edit),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showcontent(documentSnapshot);
                                        
                                      },
                                      
                                      
                                      child: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                                 const Expanded(
                                  child: Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                              
                            ),
                            
                          ),
                          
                        );
                      });
                }
                else if(!streamsnapshot.hasData){
                  return const Center(child: Text("No Data "));
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePost()),
              );
            },
            backgroundColor: Colors.blue,
            child: const Center(child: Icon(Icons.add)),
          )),
    );
  }
}

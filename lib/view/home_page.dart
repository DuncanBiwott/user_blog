
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post_app/services/auth.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 90, 114, 134),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo App"),
        actions: [
          IconButton(
            onPressed: () {
              Authenticate(auth: widget.auth).signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: ListView.builder(
        itemCount:10 ,
        itemBuilder: ((context, index) =>
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.all(20),
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Text("Name Here",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Title here",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        
                      ],
                      
                    ),
                    Text("Time Here",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                  ],
                ),
                const Text(
                  "This is where the content of my post will appear This is where the content of my post will appear",
                  style: TextStyle(fontSize: 16,color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(
                                    auth: widget.auth,
                                    firestore: widget.firestore,
                                  )),
                        );
                      },
                      child: const Text("Read"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(
                                    auth: widget.auth,
                                    firestore: widget.firestore,
                                  )),
                        );
                      },
                      child: const Text("Update"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(
                                    auth: widget.auth,
                                    firestore: widget.firestore,
                                  )),
                        );
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
         ),
      
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreatePost()),
                      );
        },
        child: Center(child: Icon(Icons.add)),
         backgroundColor: Color.fromARGB(255, 6, 98, 174),
      ),
    );
  }
}

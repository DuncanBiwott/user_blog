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
  RemoteData data = RemoteData();
  Future<List<Post>>? postList;
   List<Post>? retrievedPostList;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

Future<void> _refresh()async {

  setState(() async {
    postList=data.retrieveposts();
    retrievedPostList= await data.retrieveposts();
    _initRetrieval();
  });
   
 }

    Future<void> _initRetrieval() async {
      postList = data.retrieveposts();
      retrievedPostList= await data.retrieveposts();
    }


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
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
            future:postList ,
            builder:(BuildContext context,AsyncSnapshot<List<Post>> snapshot) {
              if(snapshot.hasData && snapshot.data!.isNotEmpty){
                return ListView.builder(
          itemCount: retrievedPostList!.length,
          itemBuilder: (context, index)
           {
            
         
           return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.all(20),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(retrievedPostList![index].name.toString(), style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),),
                                 
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                retrievedPostList![index].title.toString(),
                                style: const TextStyle(
                                  fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(retrievedPostList![index].date.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                       Text(
                        retrievedPostList![index].content.toString(),
                        style: const TextStyle(fontSize: 16, color: Colors.white),
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
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(255, 152, 0, 1))),
                            child: const Text("Update"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                             data.deleteEmployee(retrievedPostList![index].name.toString());
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            child: const Text("Delete"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
        });
              }
              else {
              return const Text("No data Found in the database ",style:TextStyle(fontSize: 32,fontWeight: FontWeight.bold),);
              }
            },
            
            ),
      ),
           );
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePost()),
          );
        },
        child: const Center(child: Icon(Icons.add)),
        backgroundColor: const Color.fromARGB(255, 6, 98, 174),
      );
    
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetPosts extends StatefulWidget {
  final String documentId;

  const GetPosts({super.key, required this.documentId});

  @override
  State<GetPosts> createState() => _GetPostsState();
}

class _GetPostsState extends State<GetPosts> {
  CollectionReference users = FirebaseFirestore.instance.collection('posts');
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    
          if (snapshot.hasError) {
            print("There is Error in Connection");
            return const Center(
              
              child: CircularProgressIndicator(),
            );
          }
    
          if (snapshot.hasData && !snapshot.data!.exists) {
            print("No Data");
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
    
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('${data["name"]}', style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),),
                                     
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${data["title"]}',
                                    style: const TextStyle(
                                      fontSize: 32,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text('${data["date"]}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                         Text(
                          '${data["content"]}',
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
                                
                              },
                              child: const Text("Read"),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(232, 187, 0, 255))),
                              child: const Text("Update"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                               
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
          }
    
          return const Center(child: CircularProgressIndicator(color: Colors.blue,));
        },
      ),
    );
  }
}
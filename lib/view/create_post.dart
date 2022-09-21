import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:post_app/services/database.dart';

class CreatePost extends StatefulWidget {
  CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  CollectionReference post = FirebaseFirestore.instance.collection('posts');
  final TextEditingController title = TextEditingController();

  final TextEditingController content = TextEditingController();
  final date = DateTime.now().toString();

  Future<void> addPost() {
    return post
        .add({
          'name': "Null",
          'title': title.text.trim(),
          'content': content.text.trim(),
          'date': date,
        })
        .then((value) => print(""))
        .catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    double height=(MediaQuery.of(context).size.height - 10);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const Text(
                    "Create a Post",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        await addPost();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Added a Post'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: EdgeInsets.only(bottom:height,
        right: 20,
        left: 20),
            ));

                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      child: const Text("Post"),
                    ),
                  )
                ],
              ),
              const Divider(),
              TextFormField(
                controller: title,
                decoration: const InputDecoration(
                  hintText: "Title",
                
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: content,
                minLines: 1,
                decoration: const InputDecoration(
                  hintText: "Say Something here .....",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              )
            ],
          ),
        ),
      ),
    );
  }
}

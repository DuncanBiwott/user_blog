import 'package:flutter/material.dart';
import 'package:post_app/models/post.dart';
import 'package:post_app/services/database.dart';

class CreatePost extends StatefulWidget {
  CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController title = TextEditingController();

  final TextEditingController content = TextEditingController();

  final RemoteData data=RemoteData();
  final date=DateTime.now().toString();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Create a Post",style: TextStyle(fontSize: 24),),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        data.create(Post(name: "None", title:title.text.trim() , content: content.text.trim(), date: date));
                        
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                      child: const Text("Post"),
                    ),
                  )
                ],
              ),
              TextFormField(
                controller: title,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: content,
                minLines: 1,
                decoration: const InputDecoration(
                  hintText: "Post Something here .....",
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

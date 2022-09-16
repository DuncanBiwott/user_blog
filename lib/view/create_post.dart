import 'dart:ui';

import 'package:flutter/material.dart';

class CreatePost extends StatelessWidget {
  CreatePost({Key? key}) : super(key: key);
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();
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
                      onPressed: () {},
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
              SizedBox(height: 20,),
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

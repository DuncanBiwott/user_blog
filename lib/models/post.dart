import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
   String? name;
   String? title;
   String? content;
   String date=DateTime.now() as String;

  Post({required this.name, required this.title, required this.content, required this.date});

  Map<String, dynamic>toMap(){
    return {
      "name": name,
       "title": title,
       "content": content, 
       "date": date
    };
      
  }

  Post.fromDocumentSnapshot(QueryDocumentSnapshot<Map<String, dynamic>>  documentSnapshot){
    name=documentSnapshot.data()["name"]as String;
    title=documentSnapshot.data()["title"]as String;
    content=documentSnapshot.data()["content"]as String;
    date=documentSnapshot.data()["date"]as String;
  }

 


}
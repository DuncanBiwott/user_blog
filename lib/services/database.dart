import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:post_app/models/post.dart';

class RemoteData{

  final FirebaseFirestore _db=FirebaseFirestore.instance;
  

 void  create(Post post)async{
  await _db.collection("posts").add(post.toMap());

  }

  void update(Post post)async{
    await _db.collection("posts").doc(post.title).update(post.toMap());


  }
  Future<void> deleteEmployee(String documentId) async {
    await _db.collection("posts").doc(documentId).delete();

  }

   Future<List<Post>> retrieveposts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("posts").get();
    return snapshot.docs
        .map((docSnapshot) => Post.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
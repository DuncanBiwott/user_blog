import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:post_app/services/auth.dart';
import 'package:post_app/view/home_page.dart';
import 'package:post_app/view/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        fontFamily: 'Raleway',
      ),
      home: Root(),
    );
    
  }
}

class Root extends StatefulWidget {
  Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:Authenticate(auth: _auth).user ,
      builder: (BuildContext context,AsyncSnapshot<User?>snapshot){
        if(snapshot.connectionState==ConnectionState.active){
          if(snapshot.data?.uid==null){

            return Login(auth: _auth, firestore: firestore);
          }else{
            return Home(auth: _auth, firestore: firestore);
          }

        }else{
          return const Scaffold(
            body: Center(
              child: Text("Loading....."),
            ),
          );
        }

        
      });
  }
}

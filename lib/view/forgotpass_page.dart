import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';

class ForgotPass extends StatefulWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController _emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Enter your Email addresss here",
              style: TextStyle(color: Color.fromARGB(255, 1, 27, 71,),fontSize: 20),),
             const SizedBox(height: 30,),
              TextFormField(
                      controller: _emailcontroller,
                      textAlign: TextAlign.start,
                      keyboardType:TextInputType.emailAddress ,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    
                       ElevatedButton(
                        onPressed: () async {
                         
                        },
                        style: ButtonStyle(
                          backgroundColor:
                                MaterialStateProperty.all(Color.fromARGB(255, 1, 27, 71))),
                        child:const Center(child:Text("Verify",style: TextStyle(color: Colors.white),)),
                      ),
                    
            ],

          ),
        ),
      ),
    );
  }
}
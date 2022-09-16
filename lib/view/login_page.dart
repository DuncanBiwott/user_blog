// ignore_for_file: deprecated_member_use, use_build_context_synchronously

// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post_app/view/home_page.dart';
import '../services/auth.dart';

class Login extends StatefulWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Login({
    Key? key,
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: Builder(builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailcontroller,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: " Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordcontroller,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final rvalue =
                        await Authenticate(auth: widget.auth).signIn(
                      email: _emailcontroller.text,
                      password: _passwordcontroller.text,
                    );
                    if (rvalue == "Success") {
                      _emailcontroller.clear();
                      _passwordcontroller.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(auth:widget.auth, firestore: widget.firestore,)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(rvalue!)),
                      );
                    }
                  },
                  child: const Text("Signin"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final rvalue =
                        await Authenticate(auth: widget.auth).createAccount(
                      email: _emailcontroller.text,
                      password: _passwordcontroller.text,
                    );
                    if (rvalue == "Success") {
                      _emailcontroller.clear();
                      _passwordcontroller.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  Home(auth: widget.auth,firestore: widget.firestore,)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(rvalue!)),
                      );
                    }
                  },
                  child: const Text("Create Account"),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

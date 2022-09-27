
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post_app/view/home_page.dart';
import 'package:post_app/view/login_page.dart';
import '../services/auth.dart';

class SignUp extends StatefulWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  SignUp({
    Key? key,
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _cpasswordcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Builder(builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("SIGN UP",style: TextStyle(color: Colors.blue,fontSize: 50),),
            
                   const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _namecontroller,
                    textAlign: TextAlign.start,
                    keyboardType:TextInputType.text ,
                    decoration: const InputDecoration(
                      label: Text("Name"),
                      hintText: "Enter name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    ),
                  ),const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailcontroller,
                    textAlign: TextAlign.start,
                    keyboardType:TextInputType.emailAddress ,
                    decoration: const InputDecoration(
                      label: Text("Email Address"),
                      hintText: "Email",
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
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      label: Text("Password"),
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
                  TextFormField(
                    controller: _cpasswordcontroller,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      label: Text("Confirm Password"),
                      hintText: "Confirm Password",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        String? rvalue;
                        if(_passwordcontroller.text==_cpasswordcontroller.text){
                          rvalue="Password does not much";
                          
                          
                        }else{
                         rvalue =
                            await Authenticate(auth: widget.auth).createAccount(
                          email: _emailcontroller.text,
                          password: _passwordcontroller.text,
                        );
                        }
                        if (rvalue == "Success") {
                          _emailcontroller.clear();
                          _passwordcontroller.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  Login(auth: widget.auth,firestore: widget.firestore,)),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(rvalue!)),
                          );
                        }
                      },
                      child:const Center(child:Text("Create Account")),
                    ),
                  ),
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

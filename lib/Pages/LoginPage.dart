// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    //loading animation
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(
                color: const Color.fromARGB(255, 0, 255, 0),
                size: 100),
          );
        });

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    //pop the loading animation
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50),

                //logo

                Icon(Icons.lock,
                    color: const Color.fromARGB(255, 0, 255, 0), size: 100),

                SizedBox(height: 50),

                //welcome back, you can login here

                Text(
                  'Welcome back, you can login here',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFeatures: [FontFeature.enable('smcp')],
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: 50),

                //email textfield

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 0, 255, 0),
                            width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 0, 255, 0)),
                      ),
                      fillColor: Colors.grey.shade900,
                      filled: true,
                      hintText: 'email',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                //password textfield

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 0, 255, 0),
                              width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 0, 255, 0)),
                        ),
                        fillColor: Colors.grey.shade900,
                        filled: true,
                        hintText: 'password',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),

                SizedBox(height: 30),

                //forget password

                Text(
                  'Forget Password?',
                  style: TextStyle(color: Colors.grey),
                ),

                SizedBox(height: 30),

                //signin button

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 255, 0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                    ),
                  ),
                ),

                SizedBox(height: 25),

                //not a memeber?

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a memeber?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: 4,
                    ),

                    //register now

                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: Text(
                        'Register now',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 255, 0),
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

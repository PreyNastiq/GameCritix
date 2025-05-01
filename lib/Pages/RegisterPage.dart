import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {

    //Loading animation
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: LoadingAnimationWidget.fallingDot(
                color: const Color.fromARGB(255, 0, 255, 0),
                size: 100),
          );
        });

    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }

    //pop the loading animation
    Navigator.of(context).pop();
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
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

                Icon(Icons.person,
                    color: const Color.fromARGB(255, 0, 255, 0), size: 100),

                SizedBox(height: 50),

                //welcome back, you can login here

                Text(
                  'Hello, Register here',
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

                SizedBox(height: 20),

                //confirm password textfield

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    obscureText: true,
                    controller: _confirmPasswordController,
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
                        hintText: 'Confirm password',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),

                SizedBox(height: 30),

                //signup button

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 255, 0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                    ),
                  ),
                ),

                SizedBox(height: 25),

                //already registered

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already Registered?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: 4,
                    ),

                    //login now

                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        'Login now',
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
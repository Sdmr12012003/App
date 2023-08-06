import 'package:flutter/material.dart';
import 'package:login/loading.dart';
import 'package:login/services/auth.dart';

class Register extends StatefulWidget {
  // const Register({super.key, required void Function() toggleView});

  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: Colors.grey[800],
              elevation: 0.0,
              title: Text('Register'),
              actions: <Widget>[
                // TextButton.icon(
                //   onPressed: () {
                //     widget.toggleView();
                //   },
                //   icon: Icon(Icons.person),
                //   label: Text('Sign In'),
                // )
                Container(
                    padding: EdgeInsets.all(5.0),
                    child: OutlinedButton(
                      onPressed: () {
                        widget.toggleView();
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                          shape:
                              StadiumBorder(), // StadiumBorder provides a cylindrical shape
                          side: BorderSide(color: Colors.white), // Border color
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 15.0),
                          backgroundColor: Colors.white),
                    )),
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(
                        0.3), // Adjust the opacity here (0.0 to 1.0)
                    BlendMode.dstATop,
                  ),
                  image: AssetImage(
                      'lib/assets/644d5cd9fc840b1718895c08048705bb.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              // child: ElevatedButton(
              //     onPressed: () async {
              //       dynamic result = await _auth.signInAnon();
              //       if (result == null) {
              //         print('error signing in');
              //       } else {
              //         print('signed in');
              //         print(result.uid);
              //       }
              //     },
              //     child: Text('Sign In')),

              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 70.0,
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 35.0,
                          letterSpacing: 1.0,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Start your Savings...',
                      style: TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 2.0,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email address',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the radius as needed
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        // filled: true,
                        // fillColor:
                        //     Colors.white, // You can set any color for the background
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the radius as needed
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        // filled: true,
                        // fillColor:
                        //     Colors.white, // You can set any color for the background
                      ),
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() => loading = true);
                          print(email);
                          print(password);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            print('Invalid email Id');
                            setState(() {
                              error = 'please supply a valid email or password';
                              loading = false;
                            });
                          } else {
                            print('You did it !!!!');
                          }
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                          shape:
                              StadiumBorder(), // StadiumBorder provides a cylindrical shape
                          side: BorderSide.none, // Border color
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 15.0),
                          backgroundColor: Colors.grey[800]),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     if (_formkey.currentState!.validate()) {
                    //       print(email);
                    //       print(password);
                    //       dynamic result = await _auth.registerWithEmailAndPassword(
                    //           email, password);
                    //       if (result == null) {
                    //         print('Invalid email Id');
                    //         setState(() =>
                    //             error = 'please supply a valid email or password');
                    //       } else {
                    //         print('You did it !!!!');
                    //       }
                    //     }
                    //   },
                    //   child: Container(
                    //     width:
                    //         30, // Set the width and height to your desired size for the button
                    //     height: 30,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color:
                    //           Colors.white, // Set the background color for the button
                    //     ),
                    //     child: Center(
                    //       child: Icon(
                    //         Icons.add, // Replace this with your button icon
                    //         size: 20, // Set the size of the button icon
                    //         color: Colors.grey, // Set the color for the button icon
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

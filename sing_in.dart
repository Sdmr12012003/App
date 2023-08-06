import 'package:flutter/material.dart';
import 'package:login/loading.dart';
import 'package:login/services/auth.dart';

class SignIn extends StatefulWidget {
  // const SignIn({super.key, required void Function() toggleView});

  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              title: Text('Sign In'),
              actions: <Widget>[
                Container(
                    padding: EdgeInsets.all(5.0),
                    child: OutlinedButton(
                      onPressed: () {
                        widget.toggleView();
                      },
                      child: Text(
                        'Register',
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
                      'lib/assets/7e204211522791ae60f66008edc85e5a.jpg'),
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

              // child: Form(
              //   key: _formkey,
              //   child: Column(
              //     children: <Widget>[
              //       SizedBox(
              //         height: 50.0,
              //       ),

              //       TextFormField(
              //         validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              //         onChanged: (val) {
              //           setState(() => email = val);
              //         },
              //       ),
              //       SizedBox(
              //         height: 20.0,
              //       ),
              //       TextFormField(
              //         validator: (val) =>
              //             val!.length < 6 ? 'Enter a password 6+ chars long' : null,
              //         obscureText: true,
              //         onChanged: (val) {
              //           setState(() => password = val);
              //         },
              //       ),
              //       SizedBox(
              //         height: 20.0,
              //       ),
              //       // ElevatedButton(
              //       //   onPressed: () async {
              //       //     if (_formkey.currentState!.validate()) {
              //       //       print(email);
              //       //       print(password);
              //       //       dynamic result =
              //       //           await _auth.signWithEmailAndPassword(email, password);
              //       //       if (result == null) {
              //       //         print('Invalid email Id');
              //       //         setState(() =>
              //       //             error = 'please supply a valid email or password');
              //       //       } else {
              //       //         print('You did it !!!!');
              //       //       }
              //       //     }
              //       //   },
              //       //   child: Text('Sign In'),
              //       //   style: ButtonStyle(
              //       //     backgroundColor:
              //       //         MaterialStateProperty.all<Color>(Colors.pink),
              //       //   ),
              //       // ),
              //       MaterialButton(
              //         minWidth: double.infinity,
              //         height: 60,
              //         onPressed: () async {
              //           if (_formkey.currentState!.validate()) {
              //             print(email);
              //             print(password);
              //             dynamic result =
              //                 await _auth.signWithEmailAndPassword(email, password);
              //             if (result == null) {
              //               print('Invalid email Id');
              //               setState(() =>
              //                   error = 'please supply a valid email or password');
              //             } else {
              //               print('You did it !!!!');
              //             }
              //           }
              //         },
              //         color: Colors.indigoAccent[400],
              //         shape: RoundedRectangleBorder(
              //             side: BorderSide(
              //               color: Colors.black,
              //             ),
              //             borderRadius: BorderRadius.circular(40)),
              //         child: Text(
              //           "Login",
              //           style: TextStyle(
              //               fontWeight: FontWeight.w600,
              //               fontSize: 16,
              //               color: Colors.white70),
              //         ),
              //       ),
              //       SizedBox(height: 12.0),
              //       Text(
              //         error,
              //         style: TextStyle(color: Colors.red, fontSize: 14.0),
              //       )
              //     ],
              //   ),
              // ),
              child: Form(
                key: _formkey,
                child: Container(
                  padding: EdgeInsets.all(15.0), // Add padding to the container
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //     color: Colors.grey,
                  //     width: 2.0,
                  //   ), // Customize border color and width
                  //   borderRadius:
                  //       BorderRadius.circular(10.0), // Customize border radius
                  // ),

                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 70.0,
                      ),
                      Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 35.0,
                            letterSpacing: 1.0,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Concise your Budgets...',
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
                                .signWithEmailAndPassword(email, password);
                            if (result == null) {
                              print('Invalid email Id');
                              setState(() {
                                error =
                                    'please supply a valid email or password';
                                loading = false;
                              });
                            } else {
                              print('You did it !!!!');
                            }
                          }
                        },
                        child: Text(
                          'Login',
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
            ),
          );
  }
}

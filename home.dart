import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/brew_list.dart';
import 'package:login/services/auth.dart';
import 'package:login/totallist.dart';
import 'package:provider/provider.dart';
import 'package:login/services/database.dart';
import 'package:login/brew.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int total = 0;
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    _fetchTotal(); // Call the method to fetch and set the total value
  }

  // Method to fetch and set the total value
  void _fetchTotal() async {
    try {
      final String? currentUserId = _auth.getCurrentUserId();
      final DatabaseService databaseService =
          DatabaseService(uid: currentUserId);

      final fetchedTotal = await databaseService.getTotal();
      setState(() {
        total = fetchedTotal;
      });
    } catch (e) {
      print('Error fetching total: $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
        centerTitle: true,
        backgroundColor: Colors.grey[600],
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Logout')),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black
                    .withOpacity(0.3), // Adjust the opacity here (0.0 to 1.0)
                BlendMode.dstATop,
              ),
              image:
                  AssetImage('lib/assets/5627b5e75dcf108b1a43e4e83fbe50f8.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                // Icon(
                //   Icons.person_2_sharp,
                //   size: 80.0,
                //   color: Colors.white,
                // ),
                Container(
                  width:
                      80, // Set the width and height to your desired size for the circle
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors
                        .grey[700], // Set the background color for the circle
                  ),
                  child: ClipOval(
                    child: Icon(
                      Icons.person, // Replace this with your person icon
                      size:
                          70, // Set the size of the person icon to fit inside the circle
                      color: Colors.white, // Set the color for the person icon
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome Back !!',
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                Text(
                  'Manage your savings ...',
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 1.0,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 80.0),
                Text(
                  'Your Savings',
                  style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                    color: Colors.grey[900],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors
                        .grey[600], // Set the background color of the container
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.7), // Set the shadow color and opacity
                        blurRadius: 15, // Adjust the blur radius for the shadow
                        offset: Offset(0, 8), // Adjust the offset of the shadow
                      ),
                    ], // Set the border radius
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Total :',
                          style: TextStyle(
                            fontSize: 20.0,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 90,
                        ),
                        Text(
                          total.toString(),
                          style: TextStyle(
                            fontSize: 20.0,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            // Add your onTap function here
                            print('Button tapped!');
                            Navigator.pushNamed(context, '/show');
                          },
                          child: Container(
                            width:
                                30, // Set the width and height to your desired size for the button
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors
                                  .white, // Set the background color for the button
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add, // Replace this with your button icon
                                size: 20, // Set the size of the button icon
                                color: Colors
                                    .grey, // Set the color for the button icon
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[600],
        onPressed: () {
          // BrewList();
          Navigator.pushNamed(context, '/show');
        },
        child: Icon(
          Icons.add,
        ),
      ),
      // Display BrewList to print the documents on the screen
    );
  }
}

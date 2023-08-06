import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/brew_list.dart';
import 'package:login/quote.dart';
import 'package:login/pages/delete.dart';
import 'package:login/services/auth.dart';
import 'package:login/services/database.dart';

import '../brew.dart';

class Show extends StatefulWidget {
  const Show({super.key});

  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> {
  List<Quote> expenses = [
    // Quote(group: 'Groceries', cost: 340),
    // Quote(group: 'Suscription', cost: 100),
    // Quote(group: 'Salary', cost: 50000),
  ];

  // Function to convert List<Brew> to List<Quote>
  // List<Quote> _convertBrewListToQuoteList(
  //     List<QueryDocumentSnapshot> documents) {
  //   return documents.map((doc) => Quote.fromSnapshot(doc)).toList();
  // }

  int total = 46000;

  void calculateTotal() async {
    int calculatedTotal = 0;
    for (Quote expense in expenses) {
      calculatedTotal += expense.cost;
    }
    final AuthService _auth = AuthService();
    final String? currentUserId = _auth.getCurrentUserId();
    final DatabaseService updation = DatabaseService(uid: currentUserId);
    await updation.updateTotal(calculatedTotal);
    setState(() {
      total = calculatedTotal;
    });
  }

  void addExpense(String name, double cost) async {
    final AuthService _auth = AuthService();
    final String? currentUserId = _auth.getCurrentUserId();
    final DatabaseService databaseService = DatabaseService(uid: currentUserId);
    int costInt = cost.toInt();
    await databaseService.addBudgetItem(name, costInt);
    print('Imbedding...');
    print(currentUserId);
    setState(() {
      // final Stream<QuerySnapshot<Object?>> brewList =
      //     await databaseService.budgetItemsStream;
      // expenses = _convertBrewListToQuoteList(
      //     brewList as List<QueryDocumentSnapshot<Object?>>);

      calculateTotal();
    });
  }

  void deleteExpense(Quote quote) async {
    final AuthService _auth = AuthService();
    final String? currentUserId = _auth.getCurrentUserId();
    final DatabaseService databaseService = DatabaseService(uid: currentUserId);
    await databaseService.deleteBudgetItem(quote.group, quote.cost);
    setState(() {
      calculateTotal();
    });
  }

  Widget listing(Quote quote) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.7), // Set the shadow color and opacity
                    blurRadius: 15, // Adjust the blur radius for the shadow
                    offset: Offset(0, 8), // Adjust the offset of the shadow
                  ),
                ],
                color: Colors
                    .grey[600], // Set the background color of the container
                borderRadius:
                    BorderRadius.circular(20), // Set the border radius
              ),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      quote.group,
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                    Text(
                      quote.cost >= 0
                          ? '+${quote.cost.toStringAsFixed(2)}'
                          : '${quote.cost.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                deleteExpense(quote);
              },
              backgroundColor: Colors.grey[600],
              child: Icon(
                Icons.delete,
              ),
            )
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  void initState() {
    super.initState();
    // Listen to the 'budgetItemsStream' stream and update the 'expenses' list
    final AuthService _auth = AuthService();
    final String? currentUserId = _auth.getCurrentUserId();
    final DatabaseService databaseService = DatabaseService(uid: currentUserId);
    databaseService.brews.listen((BrewList) {
      setState(() {
        expenses =
            BrewList.map((item) => Quote(group: item.name, cost: item.cost))
                .toList();
        calculateTotal();
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage your savings ...'),
        centerTitle: true,
        backgroundColor: Colors.grey[600],
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
                  Navigator.pushNamed(context, '/chart');
                },
                child: Text(
                  'Statistics',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                    shape:
                        StadiumBorder(), // StadiumBorder provides a cylindrical shape
                    side: BorderSide(color: Colors.white), // Border color
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    backgroundColor: Colors.white),
              )),
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
                  AssetImage('lib/assets/ac0caec1a6f0db0d96cbea7991ec60f9.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 95.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                // Icon(
                //   Icons.person_2_sharp,
                //   size: 80.0,
                //   color: Colors.white,
                // ),

                SizedBox(height: 0.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[],
                ),

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
                            showDialog(
                              context: context,
                              builder: (context) => AddExpenseDialog(
                                onExpenseAdded: addExpense,
                              ),
                            );
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
                SizedBox(
                  height: 30.0,
                ),
                Column(
                  children: expenses.map((quote) => listing(quote)).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[600],
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddExpenseDialog(
              onExpenseAdded: addExpense,
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:login/quote.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import '../services/auth.dart';
// import '../services/database.dart';

// class Charts extends StatefulWidget {
//   const Charts({Key? key});

//   @override
//   State<Charts> createState() => _ChartsState();
// }

// class _ChartsState extends State<Charts> {
//   List<Quote> quotes = [];
//   late TooltipBehavior _tooltip;

//   @override
//   void initState() {
//     super.initState();
//     // Listen to the 'budgetItemsStream' stream and update the 'expenses' list
//     final AuthService _auth = AuthService();
//     final String? currentUserId = _auth.getCurrentUserId();
//     final DatabaseService databaseService = DatabaseService(uid: currentUserId);
//     databaseService.brews.listen((BrewList) {
//       setState(() {
//         quotes =
//             BrewList.map((item) => Quote(group: item.name, cost: item.cost))
//                 .toList();
//       });
//     });
//     _tooltip = TooltipBehavior(enable: true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[800],
//         title: Text('Statistics'),
//       ),
//       body: SfCircularChart(
//         tooltipBehavior: _tooltip,
//         legend: Legend(
//           isVisible: true,
//           position:
//               LegendPosition.top, // Set the position of the legend to top right
//           borderColor: Colors.black,
//           borderWidth: 2,
//         ),
//         series: [
//           DoughnutSeries<Quote, String>(
//             dataSource: quotes,
//             xValueMapper: (Quote quote, _) => quote.group,
//             yValueMapper: (Quote quote, _) => quote.cost,
//             name: 'Expenditure',
//             dataLabelSettings: DataLabelSettings(isVisible: true),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../services/auth.dart';
import '../services/database.dart';
import 'package:login/quote.dart';

class Charts extends StatefulWidget {
  const Charts({Key? key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  List<Quote> quotes = [];
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    super.initState();
    // Listen to the 'budgetItemsStream' stream and update the 'expenses' list
    final AuthService _auth = AuthService();
    final String? currentUserId = _auth.getCurrentUserId();
    final DatabaseService databaseService = DatabaseService(uid: currentUserId);
    databaseService.brews.listen((BrewList) {
      setState(() {
        quotes =
            BrewList.map((item) => Quote(group: item.name, cost: item.cost))
                .toList();
      });
    });
    _tooltip = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('Statistics'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Analysis FYI current Budget List',
                style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              // First box container with doughnut chart
              Container(
                width: 300,
                height: 300,
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SfCircularChart(
                  tooltipBehavior: _tooltip,
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.top,
                    borderColor: Colors.black,
                    borderWidth: 2,
                  ),
                  series: [
                    DoughnutSeries<Quote, String>(
                      dataSource: quotes,
                      xValueMapper: (Quote quote, _) => quote.group,
                      yValueMapper: (Quote quote, _) => quote.cost,
                      name: 'Expenditure',
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: 150,
                      height: 200,
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <CartesianSeries>[
                          BarSeries<Quote, String>(
                            dataSource: quotes,
                            xValueMapper: (Quote quote, _) => quote.group,
                            yValueMapper: (Quote quote, _) => quote.cost,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Third box container with line chart
                  Expanded(
                    child: Container(
                      width: 150,
                      height: 200,
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <CartesianSeries>[
                          LineSeries<Quote, String>(
                            dataSource: quotes,
                            xValueMapper: (Quote quote, _) => quote.group,
                            yValueMapper: (Quote quote, _) => quote.cost,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
              // Second box container with bar chart
            ],
          ),
        ),
      ),
    );
  }
}

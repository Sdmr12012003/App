import 'package:cloud_firestore/cloud_firestore.dart';

class Quote {
  late String group;
  late int cost;

  Quote({required this.group, required this.cost});
}

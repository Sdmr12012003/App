import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/brew.dart';
import 'package:login/total.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  final CollectionReference budgetCollection =
      FirebaseFirestore.instance.collection('budget');

  Future updateUserData(int total, String name) async {
    return await brewCollection.doc(uid).set({
      'total': total,
      'name': name,
    });
  }

  Future<void> addBudgetItem(String name, int cost) async {
    try {
      final docRef =
          await budgetCollection.doc(uid).collection('budgetItems').add({
        'name': name,
        'cost': cost,
        'id':
            '', // Initialize the 'id' field with an empty string (placeholder)
      });

      // Update the 'id' field with the document ID after it's generated
      await docRef.update({'id': docRef.id});
    } catch (e) {
      print('Error adding budget item: $e');
    }
  }

  Future<void> deleteBudgetItem(String name, int cost) async {
    try {
      final querySnapshot = await budgetCollection
          .doc(uid)
          .collection('budgetItems')
          .where('name', isEqualTo: name)
          .where('cost', isEqualTo: cost)
          .get();

      if (querySnapshot.size > 0) {
        // We assume that there will be only one matching document.
        final documentSnapshot = querySnapshot.docs.first;
        await documentSnapshot.reference.delete();
        print('Document deleted successfully!');
      } else {
        print('No matching document found.');
      }
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data()
          as Map<String, dynamic>; // Explicitly cast to Map<String, dynamic>
      return Brew(
        name: data['name'] ?? 'krittikq',
        cost: data['cost'] ?? 90,
      );
    }).toList();
  }

  Future<int> getTotal() async {
    try {
      final documentSnapshot = await brewCollection.doc(uid).get();
      final data = documentSnapshot.data() as Map<String, dynamic>;
      final total = data['total'] as int;
      return total;
    } catch (e) {
      print('Error fetching total: $e');
      return 0;
    }
  }

  Future<void> updateTotal(int total) async {
    try {
      await brewCollection.doc(uid).update({
        'total': total,
      });
    } catch (e) {
      print('Error updating total: $e');
    }
  }

  // Get a stream of budget items
  Stream<List<Brew>> get brews {
    // return budgetCollection.doc(uid).collection('budgetItems').snapshots();
    return budgetCollection
        .doc(uid)
        .collection('budgetItems')
        .snapshots()
        .map(_brewListFromSnapShot);
  }

  // Stream<int> getTotalStream() {
  //   return brewCollection.doc(uid).snapshots().map((snapshot) {
  //     final data = snapshot.data() as Map<String, dynamic>;
  //     final total = data['total'] as int;
  //     return total;
  //   });
  // }
}

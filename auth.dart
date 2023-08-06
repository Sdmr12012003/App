import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/models/user.dart';
import 'package:login/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//create user object based on FirebaseUser
  UserId? _userFromFirebaseUser(User? user) {
    return user != null ? UserId(uid: user.uid) : null;
  }

//auth change user stream
  Stream<UserId?> get user {
    return _auth.authStateChanges().map((user) => _userFromFirebaseUser(user!));
  }

//sign in anoumously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// providing user_id
  String? getCurrentUserId() {
    final user = _auth.currentUser;
    return user?.uid;
  }

//sign in with email & password
  Future signWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid)
          .addBudgetItem('Suscription', 100); // Example item and cost
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData(0, 'Sahil');

      // Add a budget item for the user
      await DatabaseService(uid: user!.uid)
          .addBudgetItem('Suscription', 100); // Example item and cost
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

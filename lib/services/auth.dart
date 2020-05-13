import 'package:firebase_auth/firebase_auth.dart';
import 'package:plannusapk/models/user.dart';

class AuthService {

  final FirebaseAuth auth = FirebaseAuth.instance;

  // create user obj based on FireBase User
  User userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return auth.onAuthStateChanged.map(userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    // try and sign in, return user if found,
    // else catch the error when logging then return null
    try {
      AuthResult result = await auth.signInAnonymously();
      FirebaseUser user = result.user;
      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try { // sign in
      AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return userFromFirebaseUser(user);
    } catch (e) { // else return null
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async{
    try { // registration
      AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return userFromFirebaseUser(user);
    } catch (e) { // else return null
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}
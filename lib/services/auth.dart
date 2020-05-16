import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plannusapk/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = new GoogleSignIn();

  // create user obj based on FireBase User
  User userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(userFromFirebaseUser);
  }

  Future login() async {
    try{
      GoogleSignInAccount user = await googleSignIn.signIn();
      GoogleSignInAuthentication gsa = await user.authentication;
      final AuthCredential credential = GoogleAuthProvider
          .getCredential(idToken: gsa.idToken, accessToken: gsa.accessToken);
      AuthResult temp = await _auth.signInWithCredential(credential);
      FirebaseUser curr = temp.user;
      return userFromFirebaseUser(curr);
    } catch (err){
      print(err);
      return null;
    }
  }

  // sign in anon
  Future signInAnon() async {
    // try and sign in, return user if found,
    // else catch the error when logging then return null
    try {
      AuthResult result = await _auth.signInAnonymously();
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
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
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
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
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
      return await googleSignIn.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // google sign out
  Future googleSignOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}